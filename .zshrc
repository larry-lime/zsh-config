# If you come from bash you might have to change your $PATH.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export ZDOTDIR=$HOME/.config/zsh

# Colors and Style
autoload -Uz colors && colors
zstyle ':completion:*' menu select

source "$ZDOTDIR/functions.zsh"
# Source Files
zsh_add_file "prompt.zsh"
zsh_add_file "vim-mode.zsh"
zsh_add_file "aliases.zsh"
zsh_add_file "temp.zsh"
zsh_add_file "keybinds.zsh"
# zsh_add_file "fzf.zsh"


zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-autosuggestions"

export EDITOR="/usr/local/bin/nvim-macos/bin/nvim"
export BROWSER="Brave.app"

eval "$(/opt/homebrew/bin/brew shellenv)"

#warning: be sure to add `/home/larrylime/.cargo/bin` to your PATH to be able to run the installed binaries
# PATH="$PATH:/home/larrylime"
# PATH="$PATH:/home/larrylime/.cargo/bin"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "/home/larrylime/.bun/_bun" ] && source "/home/larrylime/.bun/_bun"
