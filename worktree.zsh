#!/usr/bin/env zsh

# Git Worktree Management with fzf
# A comprehensive script for fast worktree operations using best practices

# ===== CONFIGURATION =====
# Configure these arrays to customize post-create behavior

# Global hooks - run for all new worktrees
# Example: WT_POST_CREATE_HOOKS=("npm install" "cp ../.env .env")
typeset -a WT_POST_CREATE_HOOKS
WT_POST_CREATE_HOOKS=()

# Project-specific hooks - based on repository name
# Example: WT_PROJECT_HOOKS[my-app]="npm install && npm run setup"
typeset -A WT_PROJECT_HOOKS

# Branch pattern hooks - based on branch naming patterns
# Example: WT_BRANCH_HOOKS[feature/*]="npm install && npm test"
typeset -A WT_BRANCH_HOOKS

# Common presets (uncomment to use)
# WT_POST_CREATE_HOOKS=("echo '🚀 Worktree ready!'")
WT_PROJECT_HOOKS[henry]="pnpm install --frozen-lockfile && vercel link --project henry-web --scope henry-social-1 --yes && vercel env pull --environment development .env"
# WT_BRANCH_HOOKS[feature/*]="npm install && npm test"
# WT_BRANCH_HOOKS[hotfix/*]="npm ci"

function wt() {
    local cmd="${1:-switch}"

    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not in a git repository"
        return 1
    fi

    case "$cmd" in
        new|create)
            _wt_create "${@:2}"
            ;;
        switch|s|"")
            _wt_switch
            ;;
        remove|rm|delete)
            _wt_remove "${@:2}"
            ;;
        list|ls)
            _wt_list
            ;;
        config)
            _wt_config
            ;;
        help|--help|-h)
            _wt_help
            ;;
        *)
            echo "Unknown command: $cmd"
            _wt_help
            return 1
            ;;
    esac
}

function _wt_is_bare_setup() {
    local git_common_dir=$(git rev-parse --git-common-dir 2>/dev/null)
    git_common_dir=$(cd "$git_common_dir" 2>/dev/null && pwd)

    if [[ "$(basename "$git_common_dir")" == ".bare" ]]; then
        return 0
    fi
    if [[ "$(git rev-parse --is-bare-repository 2>/dev/null)" == "true" ]]; then
        return 0
    fi
    return 1
}

function _wt_get_root() {
    if _wt_is_bare_setup; then
        local git_common_dir=$(git rev-parse --git-common-dir 2>/dev/null)
        git_common_dir=$(cd "$git_common_dir" 2>/dev/null && pwd)
        dirname "$git_common_dir"
    else
        git rev-parse --show-toplevel 2>/dev/null
    fi
}

function _wt_create() {
    local branch_name="$1"
    local worktree_path=""

    # Get the repository root (handles bare repos)
    local repo_root=$(_wt_get_root)
    local repo_name=$(basename "$repo_root")
    local parent_dir=$(dirname "$repo_root")
    local is_bare=$(_wt_is_bare_setup && echo "true" || echo "false")

    # Fetch latest changes
    echo "Fetching latest changes..."
    git fetch --all --prune

    # Determine the main branch (main or master)
    local main_branch=""
    if git show-ref --verify --quiet refs/heads/main; then
        main_branch="main"
    elif git show-ref --verify --quiet refs/heads/master; then
        main_branch="master"
    else
        echo "Error: Could not determine main branch (main or master)"
        return 1
    fi

    # If no branch name provided, use fzf to select or create
    if [[ -z "$branch_name" ]]; then
        echo "Select an existing branch or type a new branch name:"

        # Get all branches (local and remote) and allow custom input
        branch_name=$(git branch -a --format="%(refname:short)" |
            sed 's|origin/||g' |
            sort -u |
            fzf --print-query \
                --prompt="Branch > " \
                --header="Select existing or type new branch name" \
                --preview="git log --oneline -10 {}" \
                --preview-window=right:50% | tail -1)

        if [[ -z "$branch_name" ]]; then
            echo "Cancelled"
            return 1
        fi
    fi

    # Clean up branch name (remove origin/ prefix if present)
    branch_name=${branch_name#origin/}

    # Generate worktree path based on repo type
    if [[ "$is_bare" == "true" ]]; then
        # For bare repos: create worktree as subdirectory with branch name
        worktree_path="$repo_root/${branch_name//\//-}"
    else
        # For regular repos: create as sibling directory
        worktree_path="$parent_dir/${repo_name}-${branch_name//\//-}"
    fi

    # Check if worktree already exists
    if [[ -d "$worktree_path" ]]; then
        echo "Worktree already exists at: $worktree_path"
        echo "Would you like to switch to it? (y/n)"
        read -r response
        if [[ "$response" == "y" ]]; then
            /usr/bin/cd "$worktree_path"
            echo "Switched to worktree: $worktree_path"
        fi
        return 0
    fi

    # Check if branch exists (local or remote)
    if git show-ref --verify --quiet "refs/heads/$branch_name"; then
        # Local branch exists
        echo "Creating worktree for existing local branch: $branch_name"
        git worktree add "$worktree_path" "$branch_name"
    elif git show-ref --verify --quiet "refs/remotes/origin/$branch_name"; then
        # Remote branch exists
        echo "Creating worktree for remote branch: origin/$branch_name"
        git worktree add "$worktree_path" "$branch_name"
    else
        # New branch
        echo "Creating new branch '$branch_name' from '$main_branch'"
        git worktree add -b "$branch_name" "$worktree_path" "$main_branch"
    fi

    if [[ $? -eq 0 ]]; then
        echo "✓ Worktree created at: $worktree_path"

        # Run post-create hooks
        _wt_run_hooks "$worktree_path" "$branch_name" "$repo_name"

        echo "Switching to new worktree..."
        /usr/bin/cd "$worktree_path"
        echo "Current directory: $(pwd)"
    else
        echo "✗ Failed to create worktree"
        return 1
    fi
}

function _wt_switch() {
    # Get all worktrees
    local worktrees=$(git worktree list --porcelain | grep "^worktree" | cut -d' ' -f2-)

    if [[ -z "$worktrees" ]]; then
        echo "No worktrees found"
        return 1
    fi

    # Use fzf to select worktree with preview
    local selected=$(echo "$worktrees" |
        fzf --prompt="Select worktree > " \
            --header="Switch to worktree" \
            --preview="echo '📁 Path: {}'; echo; \
                       cd {} 2>/dev/null && git branch --show-current | sed 's/^/🌿 Branch: /'; \
                       echo; echo '📝 Recent commits:'; echo; \
                       cd {} 2>/dev/null && git log --oneline -5" \
            --preview-window=right:60%)

    if [[ -n "$selected" ]]; then
        cd "$selected"
        echo "✓ Switched to: $selected"
        echo "  Branch: $(git branch --show-current)"
    else
        echo "Cancelled"
        return 1
    fi
}

function _wt_remove() {
    local force_flag=""

    # Check for force flag
    if [[ "$1" == "--force" ]] || [[ "$1" == "-f" ]]; then
        force_flag="--force"
        shift
    fi

    # Get all worktrees except the main one
    local worktree_root=$(_wt_get_root)
    local worktrees=$(git worktree list --porcelain |
        grep "^worktree" |
        cut -d' ' -f2- |
        grep -v "^${worktree_root}$")

    if [[ -z "$worktrees" ]]; then
        echo "No additional worktrees to remove"
        return 1
    fi

    # Use fzf to select worktree to remove
    local selected=$(echo "$worktrees" |
        fzf --prompt="Select worktree to remove > " \
            --header="⚠️  Remove worktree" \
            --preview="echo '📁 Path: {}'; echo; \
                       cd {} 2>/dev/null && git branch --show-current | sed 's/^/🌿 Branch: /'; \
                       echo; echo '⚠️  Status:'; \
                       cd {} 2>/dev/null && git status --short" \
            --preview-window=right:60%)

    if [[ -z "$selected" ]]; then
        echo "Cancelled"
        return 1
    fi

    # Get branch name before removal
    local branch_name=$(cd "$selected" 2>/dev/null && git branch --show-current)

    # Check for uncommitted changes if not forcing
    if [[ -z "$force_flag" ]]; then
        local changes=$(cd "$selected" 2>/dev/null && git status --porcelain)
        if [[ -n "$changes" ]]; then
            echo "⚠️  Warning: Worktree has uncommitted changes:"
            cd "$selected" && git status --short
            echo ""
            echo "Do you want to force remove? (y/n)"
            read -r response
            if [[ "$response" != "y" ]]; then
                echo "Cancelled"
                return 1
            fi
            force_flag="--force"
        fi
    fi

    # Remove the worktree
    echo "Removing worktree: $selected"
    git worktree remove $force_flag "$selected"

    if [[ $? -eq 0 ]]; then
        echo "✓ Worktree removed successfully"

        # Ask about branch deletion
        if [[ -n "$branch_name" ]]; then
            echo ""
            echo "Would you like to delete the branch '$branch_name' as well? (y/n)"
            read -r response
            if [[ "$response" == "y" ]]; then
                git branch -D "$branch_name" 2>/dev/null && echo "✓ Branch deleted" || echo "✗ Could not delete branch (might be checked out elsewhere)"
            fi
        fi
    else
        echo "✗ Failed to remove worktree"
        return 1
    fi
}

function _wt_list() {
    echo "Git Worktrees:"
    echo ""

    git worktree list --porcelain | awk '
        /^worktree/ {
            path = substr($0, 10)
            getline
            if (/^HEAD/) {
                head = substr($0, 6)
            }
            getline
            if (/^branch/) {
                branch = substr($0, 18)
            } else {
                branch = "(detached)"
            }

            # Mark current worktree
            cmd = "pwd"
            cmd | getline current_dir
            close(cmd)

            if (path == current_dir) {
                printf "→ %-50s %s\n", path, branch
            } else {
                printf "  %-50s %s\n", path, branch
            }
        }
    '
}

function _wt_run_hooks() {
    local worktree_path="$1"
    local branch_name="$2"
    local repo_name="$3"
    local hooks_to_run=()

    # Collect all applicable hooks

    # 1. Global hooks
    if [[ ${#WT_POST_CREATE_HOOKS[@]} -gt 0 ]]; then
        hooks_to_run+=("${WT_POST_CREATE_HOOKS[@]}")
    fi

    # 2. Project-specific hooks
    if [[ -n "${WT_PROJECT_HOOKS[$repo_name]}" ]]; then
        hooks_to_run+=("${WT_PROJECT_HOOKS[$repo_name]}")
    fi

    # 3. Branch pattern hooks
    for pattern in "${(@k)WT_BRANCH_HOOKS}"; do
        if [[ "$branch_name" == $~pattern ]]; then
            hooks_to_run+=("${WT_BRANCH_HOOKS[$pattern]}")
        fi
    done

    # Run hooks if any
    if [[ ${#hooks_to_run[@]} -gt 0 ]]; then
        echo ""
        echo "🔧 Running post-create hooks..."
        echo ""

        # Change to worktree directory for hook execution
        (
            cd "$worktree_path"

            for hook in "${hooks_to_run[@]}"; do
                echo "  → Executing: $hook"
                if eval "$hook"; then
                    echo "    ✓ Success"
                else
                    echo "    ✗ Failed (exit code: $?)"
                    echo "    Continuing with remaining hooks..."
                fi
                echo ""
            done
        )

        echo "✓ Post-create hooks completed"
        echo ""
    fi
}

function _wt_config() {
    echo "Git Worktree Configuration"
    echo ""
    echo "Current hooks configuration:"
    echo ""

    echo "Global hooks (WT_POST_CREATE_HOOKS):"
    if [[ ${#WT_POST_CREATE_HOOKS[@]} -eq 0 ]]; then
        echo "  (none configured)"
    else
        for hook in "${WT_POST_CREATE_HOOKS[@]}"; do
            echo "  - $hook"
        done
    fi
    echo ""

    echo "Project-specific hooks (WT_PROJECT_HOOKS):"
    if [[ ${#WT_PROJECT_HOOKS[@]} -eq 0 ]]; then
        echo "  (none configured)"
    else
        for project in "${(@k)WT_PROJECT_HOOKS}"; do
            echo "  [$project]: ${WT_PROJECT_HOOKS[$project]}"
        done
    fi
    echo ""

    echo "Branch pattern hooks (WT_BRANCH_HOOKS):"
    if [[ ${#WT_BRANCH_HOOKS[@]} -eq 0 ]]; then
        echo "  (none configured)"
    else
        for pattern in "${(@k)WT_BRANCH_HOOKS}"; do
            echo "  [$pattern]: ${WT_BRANCH_HOOKS[$pattern]}"
        done
    fi
    echo ""
    echo "To configure hooks, edit ~/.dotfiles/zsh/worktree.zsh"
}

function _wt_help() {
    cat << 'EOF'
Git Worktree Management (wt)

Usage: wt [COMMAND] [OPTIONS]

Commands:
  new, create [branch]    Create a new worktree
                         - Interactive branch selection with fzf if no branch specified
                         - Automatically fetches latest changes
                         - Creates worktree in parent directory with naming pattern
                         - Runs post-create hooks if configured

  switch, s, (default)   Switch between worktrees
                         - Interactive selection with fzf
                         - Shows branch and recent commits in preview

  remove, rm [--force]   Remove a worktree
                         - Interactive selection with fzf
                         - Checks for uncommitted changes
                         - Option to delete associated branch

  list, ls               List all worktrees
                         - Shows path and branch name
                         - Highlights current worktree

  config                 Show current hooks configuration
                         - Displays all configured post-create hooks

  help                   Show this help message

Examples:
  wt                     # Switch between worktrees (default)
  wt new                 # Create new worktree with interactive branch selection
  wt new feature/auth   # Create worktree for specific branch
  wt rm                  # Remove worktree interactively
  wt rm --force         # Force remove worktree without checks
  wt list               # List all worktrees
  wt config             # Show hooks configuration

Post-Create Hooks:
  Configure automatic commands to run after creating worktrees.
  Edit ~/.dotfiles/zsh/worktree.zsh to set:

  • WT_POST_CREATE_HOOKS - Global hooks for all worktrees
  • WT_PROJECT_HOOKS - Project-specific hooks by repo name
  • WT_BRANCH_HOOKS - Branch pattern-based hooks

  Example configuration:
    WT_POST_CREATE_HOOKS=("npm install" "cp ../.env .env")
    WT_PROJECT_HOOKS[my-app]="npm install && npm run setup"
    WT_BRANCH_HOOKS[feature/*]="npm test"

Best Practices Applied:
  • Worktrees stored in parent directory with pattern: repo-name-branch-name
  • Automatic detection of main branch (main/master)
  • Safety checks for uncommitted changes
  • Fetches latest changes before creating new worktrees
  • Interactive branch selection with fzf
EOF
}

# Alias for even faster access
alias w='wt'
