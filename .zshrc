# If you come from bash you might have to change your $PATH.
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-autosuggestions"

export EDITOR="nvim"
export BROWSER="brave.exe"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

#warning: be sure to add `/home/larrylime/.cargo/bin` to your PATH to be able to run the installed binaries
# PATH="$PATH:/home/larrylime"
# PATH="$PATH:/home/larrylime/.cargo/bin"

# Go
export GOROOT=/usr/local/go-1.18.2
export GOPATH=$HOME/projects/golang/
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.npm-global/bin
# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "/home/larrylime/.bun/_bun" ] && source "/home/larrylime/.bun/_bun"
