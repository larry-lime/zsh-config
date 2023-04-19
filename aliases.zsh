#    ___    ___
#    /   |  / (_)___ _________  _____
#   / /| | / / / __ `/ ___/ _ \/ ___/
#  / ___ |/ / / /_/ (__  )  __(__  )
# /_/  |_/_/_/\__,_/____/\___/____/

# -----------------------------------------------------------------
# File Shortcuts
# -----------------------------------------------------------------
alias down="cd $HOME/Downloads"
alias doc="cd $HOME/Documents"

# -----------------------------------------------------------------
# Aliases to Launch Applications
# -----------------------------------------------------------------
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

# -----------------------------------------------------------------
# Run Files
alias py="python3"
alias ipython="python3 -m IPython"

# -----------------------------------------------------------------
# Command Aliases
# -----------------------------------------------------------------
alias cl="clear"
alias cf="cfile"
alias so="source ~/.config/zsh/.zshrc"
alias md="mkdir"
alias rd="rmdir"
alias myip='curl http://ipecho.net/plain; echo'
alias distro='cat /etc/*-release'
alias cat="batcat"
alias ls="exa"
alias ll="exa -l"
alias la="exa -a"
alias tree="exa -T --icons"
alias \?\?="what-the-shell"
alias git\?="git-assist"
alias gh\?="gh-assist"
