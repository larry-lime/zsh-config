#!/usr/bin/zsh

FILEPATH=$(find ~/Programming ~/.config .tmux.conf ~/Life ~/Career ~/Extracurriculars -not -path '*/\.git/*'\
  | fzf --expect "alt-enter,enter" --height 100% --preview 'if [ -d {} ]; then tree -C {}; else batcat --style=numbers --color=always --line-range :500 {};fi' \
  | xargs echo)

read -r ACTION NAME <<< "${FILEPATH}"

if [ -z $NAME ]; then
  exit 0
fi

FILE=$(basename $NAME)
DIR_PATH=$(dirname $NAME)
PARENT_DIR=$(basename $DIR_PATH | tr -d '.')

# TODO I need to check if a session is alive and if it is, then change into the chosen directory
if [ -d $NAME ]; then
  tmux new-session -ds $PARENT_DIR -c $NAME
  if [ "$ACTION" = "alt-enter" ]; then
    true
  else
    if [ -z $1 ]; then
      tmux send-keys -t $PARENT_DIR.0 "$EDITOR" ENTER
    else
      tmux send-keys -t $PARENT_DIR.0 "$1" ENTER
    fi
  fi
else
  tmux new-session -ds $PARENT_DIR -c $DIR_PATH
  if [ "$ACTION" = "alt-enter" ]; then
    true
  else
    if [ -z $1 ]; then
      tmux send-keys -t $PARENT_DIR.0 "$EDITOR $FILE" ENTER
    else
      tmux send-keys -t $PARENT_DIR.0 "$1 $FILE" ENTER
    fi
  fi
fi
tmux switch-client -t $PARENT_DIR
