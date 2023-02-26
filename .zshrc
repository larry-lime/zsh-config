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

export EDITOR="nvim"

export BROWSER="Brave.app"
eval "$(/opt/homebrew/bin/brew shellenv)"

#warning: be sure to add `/home/larrylime/.cargo/bin` to your PATH to be able to run the installed binaries
if [[ "$(uname -o)" == 'GNU/Linux' ]]; then
  PATH="$PATH:/home/larry"
  PATH="$PATH:/home/larry/.cargo/bin"
elif [[  "$(uname -o)" == 'catDarwin'  ]]; then
  PATH="$PATH:/home/larrylime"
  PATH="$PATH:/home/larrylime/.cargo/bin"
fi

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "/home/larrylime/.bun/_bun" ] && source "/home/larrylime/.bun/_bun"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/lawrencelim/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/lawrencelim/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/lawrencelim/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/lawrencelim/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
