#!/usr/bin/zsh

DIR_PATH=$(find ~/Programming ~/.config ~/Life ~/Career ~/Extracurriculars -type d | fzf --height 100% --preview 'tree -C {}')
if [ -z "$DIR_PATH" ]; then
  exit 0 
fi

NAME=$(basename $DIR_PATH | tr -d '.')
tmux new-session -ds $NAME -c $DIR_PATH
tmux switch-client -t $NAME
