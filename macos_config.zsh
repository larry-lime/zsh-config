#   ____             __ _
#  / ___|___  _ __  / _(_) __ _
# | |   / _ \| '_ \| |_| |/ _` |
# | |__| (_) | | | |  _| | (_| |
#  \____\___/|_| |_|_| |_|\__, |
#                         |___/


# --------------
# PATH VARIABLES
# --------------

export PATH="$PATH:/Users/lawrencelim/.foundry/bin" # Foundry Path
export PATH="$PATH:/Users/lawrencelim/go/bin" # Go Path

# -----------
# GLOBAL VARS
# -----------

export EDITOR="nvim"
export BROWSER="open -a Arc"
export DOCKER_HOST="unix://$HOME/.colima/docker.sock" # mColima Docker Host

# -----
# EVALS
# -----

eval "$(/opt/homebrew/bin/brew shellenv)" # Homebrew Path
eval "$(starship init zsh)" # Starship Prompt