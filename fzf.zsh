[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export FZF_DEFAULT_COMMAND='find .'
# export FZF_CTRL_T_COMMAND='t'

function f(){
  FILEPATH=$(find ~/Programming ~/.config ~/Life ~/Career ~/Extracurriculars | fzf --height 100% --preview 'batcat --style=numbers --color=always --line-range :500 {}')

  if [ -z $FILEPATH ]; then
    return
  fi

  FILE=$(basename $FILEPATH)
  DIR_PATH=$(dirname $FILEPATH)
  PARENT_DIR=$(basename $DIR_PATH)
  cd $DIR_PATH
  $EDITOR $FILE
}

function c() {
  FILEPATH=$(rg --files | fzf --preview 'batcat --style=numbers --color=always {} --line-range :500 {}')
  if [ -z $FILEPATH ]; then
    return
  fi
  $EDITOR $FILEPATH
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

function s() {
  DIR_PATH=$(find ~/Programming ~/.config ~/Life ~/Career ~/Extracurriculars -type d | fzf --height 100% --preview 'tree -C {}')
  if [ -z "$DIR_PATH" ]; then
    return
  fi
  NAME="$(basename -- $DIR_PATH)"
  cd $DIR_PATH
}
