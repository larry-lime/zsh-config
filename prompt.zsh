git_info() {
    # First, check if we're in a bare git repository.
    # This is important because bare repos don't have a work-tree.
    if git rev-parse --is-bare-repository > /dev/null 2>&1; then
        # It's a bare repo. Show the directory name with a (bare) indicator.
        # No branch information is relevant here.
        echo "%F{cyan}$(basename $PWD)%f %F{yellow}(bare)%f"

    # If not bare, check if we're in a standard git working tree.
    elif git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        # Get the git root directory
        local git_root=$(git rev-parse --show-toplevel)
        # Get the current branch or commit hash
        local branch=$(git symbolic-ref --short HEAD 2> /dev/null || git rev-parse --short HEAD)
        # Get the relative path from git root
        local rel_path=${PWD#$git_root/}
        
        # If we're in the git root, just show the directory name
        if [[ "$PWD" == "$git_root" ]]; then
            echo "%F{cyan}$(basename $git_root)%f on %F{magenta} $branch%f"
        else
            echo "%F{cyan}$(basename $git_root)/$rel_path%f on %F{magenta} $branch%f"
        fi
    else
        # If not in any kind of git repo, just show the current directory
        echo "%F{cyan}%~%f"
    fi
}

# Set the prompt
setopt PROMPT_SUBST
PROMPT='$(git_info)
%F{green}➜ '
