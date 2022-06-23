#!/usr/bin/zsh

FILEPATH=$(find ~/Programming ~/.config ~/Life ~/Career ~/Extracurriculars | fzf --height 100% --preview 'batcat --style=numbers --color=always --line-range :500 {}')

if [ -z $FILEPATH ]; then
    exit 0
fi

FILE=$(basename $FILEPATH)
DIR_PATH=$(dirname $FILEPATH)
PARENT_DIR=$(basename $DIR_PATH)

if [ -z "$TMUX" ]; then
  tmux new-session -s $PARENT_DIR -c $DIR_PATH
  # exit 0
else
  tmux new-session -ds $PARENT_DIR -c $DIR_PATH
fi

tmux send-keys -t $PARENT_DIR.0 "$EDITOR $FILE" ENTER
tmux switch-client -t $PARENT_DIR
