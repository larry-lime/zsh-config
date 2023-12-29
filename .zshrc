#    _______| |__  _ __ ___ 
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__ 
# (_)___|___/_| |_|_|  \___|


# --------
# SETTINGS
# --------

autoload -Uz colors && colors
zstyle ':completion:*' menu select

# ------------
# SOURCE FILES
# ------------

source "$ZDOTDIR/functions.zsh"
zsh_add_file "config.zsh"
zsh_add_file "aliases.zsh"
zsh_add_file "vim-mode.zsh"
zsh_add_file "colors.zsh"
zsh_add_file "keybinds.zsh"
# zsh_add_file "prompt.zsh" # Disabled for Starship

# -------
# PLUGINS
# -------

zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
