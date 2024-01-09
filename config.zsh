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
export PATH="/Users/lawrencelim/.local/bin:$PATH" # Poetry Path
export PATH="$PATH:/Users/lawrencelim/go/bin" # Go Path
export PATH="$PATH:/Users/lawrencelim/.local/share/bob/nvim-bin"


# -----------
# GLOBAL VARS
# -----------

export EDITOR="nvim"
export BROWSER="open -a Arc"
export DOCKER_HOST="unix://$HOME/.colima/docker.sock" # Colima Docker Host
export GCLI=false # Global state var to lazy load Github Copilot CLI

# -----
# EVALS
# -----

eval "$(/opt/homebrew/bin/brew shellenv)" # Homebrew Path
eval "$(starship init zsh)" # Starship Prompt
eval "$(zoxide init zsh)" # Zoxide
