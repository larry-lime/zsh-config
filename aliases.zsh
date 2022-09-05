#     ___    ___                     
#    /   |  / (_)___ _________  _____
#   / /| | / / / __ `/ ___/ _ \/ ___/
#  / ___ |/ / / /_/ (__  )  __(__  ) 
# /_/  |_/_/_/\__,_/____/\___/____/

# -----------------------------------------------------------------
# File Shortcuts
# -----------------------------------------------------------------
alias home="cd /mnt/c/Users/larry"
alias down='cd /mnt/c/Users/larry/Downloads'
alias doc='cd /mnt/c/Users/larry/OneDrive/Documents'
alias desk='cd /mnt/c/Users/larry/OneDrive/Desktop'
alias nvimrc='cd ~/.config/nvim'
alias zshrc='cd ~/.config/zsh'
alias tmuxrc='cd ~/.config/tmux'
alias lbin='cd ~/.local/bin'
alias nplug='cd ~/.local/share/nvim/site/pack/packer/start'

# -----------------------------------------------------------------
# Aliases to Launch Applications
# -----------------------------------------------------------------
alias word="winword.exe"
alias explore="explorer.exe"
alias nv="nvim"
alias tt="taskwarrior-tui"
alias tsource="tmux source ~/.config/tmux/tmux.conf"
alias tconf="cd ~/.config/tmux/ && nvim tmux.conf"
alias tp="Typora.exe"
alias t="/usr/local/bin/tmux"
alias tnav="source $HOME/.local/bin/tnav"
alias lg="lazygit"
alias chrome="/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe"

# -----------------------------------------------------------------
# Run Files
# -----------------------------------------------------------------
alias ahk="Autohotkey.exe"
alias py="python3"

# -----------------------------------------------------------------
# Command Aliases
# -----------------------------------------------------------------
alias cl="clear"
alias cf="cfile"
alias so="source ~/.config/zsh/.zshrc"
alias md="mkdir"
alias rd="rmdir"
alias pwsh="powershell.exe"
alias startup="pwsh -File func.ps1"
alias al="alias"
alias myip='curl http://ipecho.net/plain; echo'
alias distro='cat /etc/*-release'
alias cat="batcat"
alias ls="exa"
alias ll="exa -l"
alias tree="exa -T --icons"
alias hhstart="~/.local/bin/hardhat-boilerplate"
alias genr="~/.local/bin/generate-README"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
#alias cd="z"

# -----------------------------------------------------------------
# Git Aliases
# -----------------------------------------------------------------
alias github= 'brave.exe "https://github.com/larry-lime"' 
alias gtoken='nvim "/mnt/c/Users/larry/nyu/ics/git_learn/token.txt"'
alias gls='git ls-tree --full-tree --name-only -r HEAD'
