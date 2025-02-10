git_info() {
    # Check if we're in a git repository
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        # Get the git root directory
        local git_root=$(git rev-parse --show-toplevel)
        # Get the current branch
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
        # If not in a git repo, just show the current directory
        echo "%F{cyan}%~%f"
    fi
}

# Set the prompt
setopt PROMPT_SUBST
PROMPT='$(git_info)
%F{green}➜ '
# PROMPT='%F{cyan}%c %F{default}on %F{red} ${vcs_info_msg_0_}%f
# %F{green}➜ '
