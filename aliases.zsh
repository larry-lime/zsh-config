#     _    _ _
#    / \  | (_) __ _ ___  ___  ___
#   / _ \ | | |/ _` / __|/ _ \/ __|
#  / ___ \| | | (_| \__ \  __/\__ \
# /_/   \_\_|_|\__,_|___/\___||___/

# --------------
# FILE SHORTCUTS
# --------------

alias down="cd $HOME/Downloads"
alias doc="cd $HOME/Documents"

# ------------------------------
# ALIASES TO LAUNCH APPLICATIONS
# ------------------------------

alias o="open"
alias nv="nvim"
alias tsource="tmux source ~/.config/tmux/tmux.conf"
alias tconf="cd ~/.config/tmux/ && nvim tmux.conf"
alias t="tmux"
alias st="$HOME/.dotfiles/.local/bin/start_tmux"
alias start-tmux="$HOME/.dotfiles/.local/bin/start_tmux"
alias tnav="source $HOME/.local/bin/tnav"
alias lg="lazygit"
alias hg="hugo"
alias of="open . -a finder"
alias dw="open ~/Downloads/ -a finder<CR>"
alias ger="ranger"
alias sep="/Users/lawrencelim/Scripts/generate-separator.sh"

alias py="python3"
alias ipython="python3 -m IPython"

# ---------------
# COMMAND ALIASES
# ---------------

alias cl="clear"
alias cf="cfile"
alias so="source ~/.config/zsh/.zshrc"
alias md="mkdir"
alias rd="rmdir"
alias myip='curl http://ipecho.net/plain; echo'
alias distro='cat /etc/*-release'
alias ls="exa"
alias ll="exa -l -snew"
alias la="exa -a"
alias tree="exa -T --icons"
alias code="code-insiders"
alias \?\?="what-the-shell"
alias git\?="git-assist"
alias gh\?="gh-assist"
