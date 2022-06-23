[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export FZF_DEFAULT_COMMAND='find .'
# export FZF_CTRL_T_COMMAND='t'

function f(){
  FILEPATH=$(find . | fzf --height 70% --layout=reverse --preview 'batcat --style=numbers --color=always --line-range :500 {}')
  if [ -z "$FILEPATH" ]; then
    return
  fi
  basename "$FILEPATH"
  FILE="$(basename -- $FILEPATH)"
  DIR_PATH=$(dirname $FILEPATH)
  cd $DIR_PATH
  $EDITOR $FILE
}

function s() {
  cd ~
  DIR_PATH=$(find . -type d | fzf --height 70% --layout=reverse --preview 'tree -C {}')
  if [ -z "$DIR_PATH" ]; then
    return
  else
    basename "$DIR_PATH"
    NAME="$(basename -- $DIR_PATH)"
    cd $DIR_PATH
    if [ -z "$TMUX" ]; then
      tmux new -s $NAME
    else
      return
    fi
  fi
}

function fd(){
  cd $(find . -type d | fzf --height 70% --layout reverse --preview 'tree -C {}')
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    *)            fzf "$@" ;;
  esac
}
