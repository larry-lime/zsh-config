[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export FZF_DEFAULT_COMMAND=''
# export FZF_CTRL_T_COMMAND=''

# This looks for both files and directories
# TODO update this to search for either files and/or directories and take arguments
# I can also turn this into a function where it accepts arguments like telescope. Then I can use it purely as an executable
# In the function, add the ability to copy the file path to clipboard and just display it as the output
  # Make this relative
function f(){
  FILEPATH=$(find ~/Dall-E_images ~/Programming ~/.config .tmux.conf ~/Life ~/Career ~/Extracurriculars -not -path '*/\.git/*'\
    | fzf --expect "alt-enter,enter" --height 100% --preview 'if [ -d {} ]; then tree -C {}; else batcat --style=numbers --color=always --line-range :500 {};fi' \
    | xargs echo)

  read -r ACTION NAME <<< "${FILEPATH}"

  if [ -z $NAME ]; then
    return
  fi

  FILE=$(basename $NAME)
  DIR_PATH=$(dirname $NAME)
  PARENT_DIR=$(basename $FILE | tr -d '.')

  if [ -z "$TMUX" ]; then

    tmux start-server
    if [ -d $NAME ]; then # If the selection is a directory

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

    else

      if [ "$PARENT_DIR" = "zsh "] || [ "$PARENT_DIR" = "nvim" ] || [ "$PARENT_DIR" = "tmux" ]; then
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
    fi
    tmux attach
  else

    if [ -d $NAME ]; then
      cd $NAME
      if [ "$ACTION" = "alt-enter" ]; then
        return
      fi

      if [ -z $1 ]; then
        $EDITOR
      else
        $1
      fi

    else
      cd $DIR_PATH
      if [ "$ACTION" = "alt-enter" ]; then
        return
      fi

      if [ -z $1 ]; then
        $EDITOR $FILE
      else
        $1 $FILE
      fi
    fi
  fi
}

# TODO Update this to work like the f function or delete it
function fd() {
  DIR_PATH=$(find ~/Programming ~/.config ~/Life ~/Career ~/Extracurriculars -type d | fzf --height 100% --preview 'tree -C {}')
  if [ -z "$DIR_PATH" ]; then
    return
  fi
  NAME=$(basename $DIR_PATH | tr -d '.')

  if [ -z "$TMUX" ]; then
    tmux start-server
    tmux new-session -ds $NAME -c $DIR_PATH
    tmux attach
  else
    cd $DIR_PATH
  fi
}

# TODO Update this to work like the f function
function fc() {
  # FILEPATH=$(rg --files --hidden | fzf --preview 'batcat --style=numbers --color=always {} --line-range :500 {}')
  FILEPATH=$(find . -not -path '*/\.git/*' | fzf --preview 'if [ -d {} ]; then tree -C {}; else batcat --style=numbers --color=always --line-range :500 {};fi')
  if [ -z $FILEPATH ]; then
    return
  fi
  if [ -z $1 ]; then
    $EDITOR $FILEPATH
  else
    $1 $FILEPATH
  fi
}

function g() {
        out=$(rg \
        --column \
        --line-number \
        --no-column \
        --no-heading \
        --fixed-strings \
        --ignore-case \
        --hidden \
        --follow \
        --glob '!.git/*' "$1" \
  | awk -F  ":" '/1/ {start = $2<40 ? 0 : $2 - 40; end = $2 + 40; print $1 " " $2 " " start ":" end}' \
  | fzf --preview 'batcat --color always {1} --highlight-line {2} --line-range {3}')
        
  if [ -z "$out" ]; then
    return
  fi
  read -r filename line <<< "${out}"
  LINE_NUMBER=${line%% *}
  $EDITOR -c ":$LINE_NUMBER" $filename
}
