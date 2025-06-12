# ===================================================================
# == Custom Git Worktree Functions with FZF Integration
# ===================================================================

# gwtc (Git Worktree Checkout)
# Interactively selects a git branch to either CD into its existing
# worktree or create a new one.
gwtc() {
  # Ensure we are in a git repository
  if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: Not in a git repository." >&2
    return 1
  fi

  # Get the selected branch name using fzf
  local branch
  branch=$(git for-each-ref --format='%(refname:short)' refs/heads/ | fzf --height 40% --reverse --prompt="Checkout branch> ")

  # Exit if fzf was cancelled
  if [[ -z "$branch" ]]; then
    echo "No branch selected. Aborting."
    return 1
  fi

  # Find the path of an existing worktree for this specific branch.
  local existing_path
  existing_path=$(git worktree list --porcelain | \
      grep -B 2 "branch refs/heads/${branch}$" | \
      grep "worktree " | \
      sed 's/worktree //')

  if [[ -n "$existing_path" ]]; then
    # If a path was found, the worktree already exists.
    echo "Worktree for branch '${branch}' already exists."
    echo "Changing directory to: ${existing_path}"
    cd "${existing_path}"
  else
    # --- THE FIX IS HERE ---
    # Worktree does not exist, so we create it.
    
    # 1. Find the repository root. `git rev-parse --git-dir` reliably
    #    returns the path to the .git directory or the bare repo itself.
    local repo_root
    repo_root=$(git rev-parse --git-dir)

    # 2. Construct the absolute path for the new worktree.
    #    It will be a new directory named after the branch, inside the repo root.
    local new_worktree_path="${repo_root}/${branch}"
    
    echo "Creating new worktree for branch '${branch}' at: ${new_worktree_path}"
    
    # 3. Use the explicit 'git worktree add <path> <branch>' form.
    #    This ensures it's created at the absolute path, not a relative one.
    if git worktree add "${new_worktree_path}" "${branch}"; then
      echo "Successfully created worktree. Changing directory..."
      cd "${new_worktree_path}"
    else
      echo "Error: Failed to create worktree." >&2
      # Clean up a potentially created but empty directory on failure
      if [ -d "${new_worktree_path}" ]; then
        rm -rf "${new_worktree_path}"
      fi
      return 1
    fi
  fi
}


# gwtd (Git Worktree Delete)
# Interactively selects and deletes a git worktree.
gwtd() {
  # Ensure we are in a git repository
  if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: Not in a git repository." >&2
    return 1
  fi

  # Use awk to parse the porcelain output and format for fzf
  local selection
  selection=$(git worktree list --porcelain | \
    awk '/^worktree / {path=$2} /^branch / {print substr($2, 12) " -> " path}')

  if [[ -z "$selection" ]]; then
    echo "No worktrees to delete."
    return 0
  fi

  # Let the user choose with fzf
  local choice
  choice=$(echo "$selection" | fzf --height 40% --reverse --prompt="Select worktree to DELETE> ")

  # Exit if fzf was cancelled
  if [[ -z "$choice" ]]; then
    echo "No worktree selected. Aborting."
    return 1
  fi

  # Extract the path and branch from the formatted string
  local worktree_path=$(echo "$choice" | sed 's/.* -> //')
  local branch=$(echo "$choice" | sed 's/ -> .*//')

  # --- FIX IS HERE ---
  # Confirmation prompt, written in a cross-compatible way for Bash and Zsh.
  echo -n "Are you sure you want to permanently delete worktree for branch '${branch}' at '${worktree_path}'? (y/N) "
  read -r -k 1 REPLY # In Zsh, -k 1 reads one character. In Bash, -n 1. -k is often more compatible.
  echo # Move to a new line

  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Deletion cancelled."
    return 1
  fi

  echo "Removing worktree and its directory: ${worktree_path}"
  if git worktree remove --force "${worktree_path}"; then
    echo "Successfully removed worktree."
  else
    echo "Error: Failed to remove worktree." >&2
    return 1
  fi
}
