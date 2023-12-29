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

# -----------
# GLOBAL VARS
# -----------

export EDITOR="nvim"
export BROWSER="Brave.app"
export DOCKER_HOST="unix://$HOME/.colima/docker.sock" # Colima Docker Host
export GCLI=false # Global state var to lazy load Github Copilot CLI

# -----
# EVALS
# -----

eval "$(/opt/homebrew/bin/brew shellenv)" # Homebrew Path
eval "$(starship init zsh)" # Starship Prompt
eval "$(zoxide init zsh)" # Zoxide

# -------------
# CODEWHISPERER
# -------------

# CodeWhisperer pre block. Keep at the top of this file.
# [[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"

# Fig pre block. Keep at the top of this file.
# [[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# Fig post block. Keep at the bottom of this file.
# [[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

# CodeWhisperer post block. Keep at the bottom of this file.
# [[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"
