#     _    _ _
#    / \  | (_) __ _ ___  ___  ___
#   / _ \ | | |/ _` / __|/ _ \/ __|
#  / ___ \| | | (_| \__ \  __/\__ \
# /_/   \_\_|_|\__,_|___/\___||___/

# -----------------------
# REMAPPED SHELL COMMANDS
# -----------------------

alias ls="exa"
alias ll="exa -l -snew"
alias la="exa -a"
alias tree="exa -T --icons"
alias cat="bat"
# alias cd="z" # zoxide

# ------------------------
# SHORTENED SHELL COMMANDS
# ------------------------

alias o="open"
alias md="mkdir"
alias rd="rmdir"
alias cl="clear"

# --------------
# DIRECTORY SHORTCUTS
# --------------

alias down="cd $HOME/Downloads"
alias doc="cd $HOME/Documents"

# --------------------
# RUN AND SOURCE FILES
# --------------------

alias tnav="source tnav"
alias tsource="tmux source ~/.config/tmux/tmux.conf"
alias sep="/Users/lawrencelim/Scripts/generate-separator.sh"
alias so="source ~/.config/zsh/.zshrc"

# ------------------
# SHORTENED COMMANDS
# ------------------

alias nv="nvim"
alias ne="neovide"
alias leet="nvim leetcode.nvim"
alias t="tmux"
alias hg="hugo"
alias lg="lazygit"
alias py="python3"
alias ipython="python3 -m IPython"
alias code="code-insiders"

alias \?\?="gh copilot suggest -t shell "
alias git\?="gh copilot suggest -t git"
alias gh\?="gh copilot suggest -t gh"
