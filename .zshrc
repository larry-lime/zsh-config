# Source fzf key bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Macchiato
export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

# Latte
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
# --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
# --color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"

# Colors and Style
autoload -Uz colors && colors
zstyle ':completion:*' menu select

source "$ZDOTDIR/functions.zsh"
# Source Files
# zsh_add_file "prompt.zsh"
zsh_add_file "aliases.zsh"
zsh_add_file "keybinds.zsh"
zsh_add_file "vim-mode.zsh"

zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-autosuggestions"

# Export foundry path
export PATH="$PATH:/Users/lawrencelim/.foundry/bin"
# Export poetry path
# export PATH="/Users/lawrencelim/.local/bin:$PATH"

export EDITOR="nvim"
export BROWSER="Brave.app"
export GCLI=false # Global state var to lazy load Github Copilot CLI
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

eval "$(starship init zsh)"
