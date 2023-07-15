# If you come from bash you might have to change your $PATH.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
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
zsh_add_file "keybinds.zsh"
zsh_add_file "vim-mode.zsh"
# zsh_add_file "temp.zsh"
# zsh_add_file "fzf.zsh"

zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-autosuggestions"

# Export foundry path
export PATH="$PATH:/Users/lawrencelim/.foundry/bin"
# Export poetry path
export PATH="/Users/lawrencelim/.local/bin:$PATH"

export EDITOR="nvim"
export BROWSER="Brave.app"
export GCLI=false # Global state var to lazy load Github Copilot CLI
eval "$(/opt/homebrew/bin/brew shellenv)"
PATH="$PATH:/home/larrylime"
PATH="$PATH:/home/larrylime/.cargo/bin"
PATH="$PATH:/Users/lawrencelim/go/bin"

# eval "$(starship init zsh)"
