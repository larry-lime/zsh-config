#!/usr/bin/zsh

# I have to learn how to make this file executable by zsh
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

if [ -d $NAME ]; then

  if [ "$FILE" = "zsh" ] || [ "$FILE" = "nvim" ] || [ "$FILE" = "tmux" ]; then
    tmux new-session -ds "config" -c $NAME
  else
    tmux new-session -ds $FILE -c $NAME
  fi

  if [ "$ACTION" = "alt-enter" ]; then
    true
  else
    if [ -z $1 ]; then
      tmux send-keys -t $FILE.0 "$EDITOR" ENTER
    else
      tmux send-keys -t $FILE.0 "$1" ENTER
    fi
  fi
  tmux switch-client -t $FILE
else

  if [ "$PARENT_DIR" = "zsh" ] || [ "$PARENT_DIR" = "nvim" ] || [ "$PARENT_DIR" = "tmux" ]; then
    tmux new-session -ds "config" -c $DIR_PATH
  else
    tmux new-session -ds $PARENT_DIR -c $DIR_PATH
  fi

  if [ "$ACTION" = "alt-enter" ]; then
    true
  else
    if [ -z $1 ]; then
      tmux send-keys -t $PARENT_DIR.0 "$EDITOR $FILE" ENTER
    else
      tmux send-keys -t $PARENT_DIR.0 "$1 $FILE" ENTER
    fi
  fi
  tmux switch-client -t $PARENT_DIR
fi
