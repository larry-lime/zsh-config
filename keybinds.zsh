bindkey -s '^t' 'tnav\n' # find files in select folders
bindkey -s '^g' 'tnav -r\n' # find files in select folders
bindkey -s '^o' 'tnav -o\n' # find files in select folders
bindkey -s '^h' 'cd ~\n' # go home
bindkey -s '^b' 'cd ..\n' # go to previous directory
bindkey -s '^_' 'cd /\n' # go to root directory
bindkey -s '\et' 'tmux\n' # launch tmux
bindkey -s '^a' '**	' # fzf autocomplee
bindkey -s '^z' 'fg\n' # fzf autocomplee

# Enable shift tab to do reverse select
bindkey '^[[Z' reverse-menu-complete
