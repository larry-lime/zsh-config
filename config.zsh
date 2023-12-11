#   ____             __ _
#  / ___|___  _ __  / _(_) __ _
# | |   / _ \| '_ \| |_| |/ _` |
# | |__| (_) | | | |  _| | (_| |
#  \____\___/|_| |_|_| |_|\__, |
#                         |___/

# Export foundry path
export PATH="$PATH:/Users/lawrencelim/.foundry/bin" # Foundry Path
export PATH="/Users/lawrencelim/.local/bin:$PATH" # Poetry Path
export PATH="$PATH:/Users/lawrencelim/go/bin" # Go Path

export EDITOR="nvim"
export BROWSER="Brave.app"
export DOCKER_HOST="unix://$HOME/.colima/docker.sock" # Colima Docker Host
export GCLI=false # Global state var to lazy load Github Copilot CLI

eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(starship init zsh)" # Starship Prompt
