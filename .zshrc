source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

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
export BROWSER="firefox"
export GCLI=false


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
