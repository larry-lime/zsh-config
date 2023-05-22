# If you come from bash you might have to change your $PATH.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export ZDOTDIR=$HOME/.config/zsh

# Colors and Style
autoload -Uz colors && colors
zstyle ':completion:*' menu select

source "$ZDOTDIR/functions.zsh"
# Source Files
zsh_add_file "prompt.zsh"
zsh_add_file "aliases.zsh"
zsh_add_file "temp.zsh"
zsh_add_file "keybinds.zsh"
zsh_add_file "vim-mode.zsh"
# zsh_add_file "fzf.zsh"

zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-autosuggestions"

# Export foundry path
export PATH="$PATH:/Users/lawrencelim/.foundry/bin"

export EDITOR="nvim"
export BROWSER="brave-browser"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

if [[ "$(uname -o)" == 'GNU/Linux' ]]; then
  PATH="$PATH:/home/larry"
  PATH="$PATH:/home/larry/.cargo/bin"
elif [[  "$(uname -o)" == 'catDarwin'  ]]; then
  PATH="$PATH:/home/larrylime"
  PATH="$PATH:/home/larrylime/.cargo/bin"
fi

export PATH="/home/larrylime/anaconda3/bin:$PATH"
