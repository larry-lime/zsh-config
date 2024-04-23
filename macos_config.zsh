#   ____             __ _
#  / ___|___  _ __  / _(_) __ _
# | |   / _ \| '_ \| |_| |/ _` |
# | |__| (_) | | | |  _| | (_| |
#  \____\___/|_| |_|_| |_|\__, |
#                         |___/


# --------------
# PATH VARIABLES
# --------------

export PATH="$PATH:$HOME/.foundry/bin" # Foundry Path
export PATH="$PATH:$HOME/go/bin" # Go Path
export PATH="$PATH:$HOME/.local/bin" # Go Path
export PATH="$PATH:$HOME.local/share/bob/nvim-bin" # Bob path

# -----------
# GLOBAL VARS
# -----------

export DYLD_LIBRARY_PATH="/opt/homebrew/lib/"
export EDITOR="nvim"
export BROWSER="open -a Arc"
export DOCKER_HOST="unix://$HOME/.colima/docker.sock" # mColima Docker Host
export PNPM_HOME="/Users/lawrencelim/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# -----
# EVALS
# -----

eval "$(/opt/homebrew/bin/brew shellenv)" # Homebrew Path
eval "$(starship init zsh)" # Starship Prompt
eval $(opam env)
