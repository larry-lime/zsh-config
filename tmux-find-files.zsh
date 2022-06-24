#!/usr/bin/zsh

FILEPATH=$(find ~/Programming ~/.config ~/Life ~/Career ~/Extracurriculars | fzf --height 100% --preview 'batcat --style=numbers --color=always --line-range :500 {}')

if [ -z $FILEPATH ]; then
    exit 0
fi

FILE=$(basename $FILEPATH)
DIR_PATH=$(dirname $FILEPATH)
PARENT_DIR=$(basename $DIR_PATH | tr -d '.')

tmux new-session -ds $PARENT_DIR -c $DIR_PATH
tmux send-keys -t $PARENT_DIR.0 "$EDITOR $FILE" ENTER
tmux switch-client -t $PARENT_DIR
