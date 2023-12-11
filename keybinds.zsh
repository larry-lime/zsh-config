#  _  __          _     _           _     
# | |/ /___ _   _| |__ (_)_ __   __| |___ 
# | ' // _ \ | | | '_ \| | '_ \ / _` / __|
# | . \  __/ |_| | |_) | | | | | (_| \__ \
# |_|\_\___|\__, |_.__/|_|_| |_|\__,_|___/
#           |___/                         

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # Source fzf keybinds

bindkey -s '^t' 'tnav\n' # find files in select folders
bindkey -s '^g' 'tnav -r\n' # find files in select folders
bindkey -s '^o' 'tnav -o\n' # find files in select folders
bindkey -s '^h' 'cd ~\n' # go home
bindkey -s '^k' 'cd ~/Downloads/ && exa -l -snew\n' # go home
bindkey -s '^b' 'cd ..\n' # go to previous directory
bindkey -s '^_' 'cd /\n' # go to root directory
bindkey -s '\et' 'tmux\n' # launch tmux
bindkey -s '^a' '**	' # fzf autocomplee
bindkey -s '^z' 'fg\n' # fzf autocomplee
bindkey '^[[Z' reverse-menu-complete # # Enable shift tab to do reverse select
