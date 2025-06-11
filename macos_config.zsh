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
export PATH="$PATH:$HOME/.go" # Go Path
export PATH="$PATH:$HOME/go/bin" # Go Binaries
export PATH="$PATH:$HOME/.local/bin" # Go Path
export PATH="$PATH:$HOME.local/share/bob/nvim-bin" # Bob path
export PATH="$PATH:/Users/lawrencelim/.sp1/bin"
export PATH="$PATH:/Users/lawrencelim/.risc0/bin"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

# -----------
# GLOBAL VARS
# -----------

export DYLD_LIBRARY_PATH="/opt/homebrew/lib/"
export EDITOR="nvim"
export BROWSER="open -a Arc"
export PNPM_HOME="/Users/lawrencelim/Library/pnpm"
export TERMINAL_THEME="dark"
export XDG_CONFIG_HOME="$HOME/.config"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk

# -----------
# DOCKER
# -----------
export DOCKER_HOST="unix://$XDG_CONFIG_HOME/colima/default/docker.sock" # mColima Docker Host

case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# -----
# EVALS
# -----

eval "$(/opt/homebrew/bin/brew shellenv)" # Homebrew Path
# eval "$(starship init zsh)" # Starship Prompt
eval $(opam env)
eval "$(fnm env --use-on-cd)"
. "$HOME/.cargo/env"
source /Users/lawrencelim/.gemini-api-key
