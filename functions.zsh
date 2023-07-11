#     ______                 __  _                 
#    / ____/_  ______  _____/ /_(_)___  ____  _____
 #  / /_  / / / / __ \/ ___/ __/ / __ \/ __ \/ ___/
#  / __/ / /_/ / / / / /__/ /_/ / /_/ / / / (__  ) 
# /_/    \__,_/_/ /_/\___/\__/_/\____/_/ /_/____/

# -----------------------------------------------------------------
# Plugins from chris@machine
# -----------------------------------------------------------------
function zsh_add_file() {
    # Function to source files if they exist
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then 
        # For plugins
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}

function zsh_add_completion() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then 
        # For completions
		completion_file_path=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
		fpath+="$(dirname "${completion_file_path}")"
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
		fpath+=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
        [ -f $ZDOTDIR/.zccompdump ] && $ZDOTDIR/.zccompdump
    fi
	completion_file="$(basename "${completion_file_path}")"
	if [ "$2" = true ] && compinit "${completion_file:1}"
}

# -----------------------------------------------------------------
# My Custom Z-Shell Commands
# -----------------------------------------------------------------
function oj() {
  if [ $# -eq 0 ]; then
      jobs -d
  else
      fg %$1
  fi
}

function kj ()
{
  kill %$1
}

function take() {
    mkdir -p -- "$1" &&
    cd -P -- "$1"
    echo $(pwd) | tr "\n" " " | clip.exe 
    CLIP=$(pwd)
}

function ii() {
    FILE=$@
    CHECK="${FILE##*.}"
    if [[ ! -f $1 ]] then # Create the file if it doesn't exist
        touch $1
    fi
    # Add custom defaults
    if [ "$CHECK" = "md" ]; then
        nvim $FILE
    elif [ "$CHECK" = "pdf" ]; then
      SumatraPDF.exe $FILE
    elif [ "$CHECK" = "py" ]; then
        nvim $FILE
    elif [ "$CHECK" = "txt" ]; then
        nvim $FILE
    # Else use system defaults
    else
        powershell.exe -c "ii $FILE"
    fi
}

function tp() {
  if [[ $1 ]]; then
    open $1 -a Typora.app
  else
    open . -a Typora.app
  fi
}

function ppy() {
    powershell.exe -c "python3 $1"
}

function ccont() {
    if [ -f "$1" ]; then
        CLIP=$(cat $1)
        echo $CLIP | tr "\n" " " | clip.exe 
    else
        echo "File does not exist"
    fi
}

function cfile() {
    CLIP=$(realpath $1)
    echo $CLIP | tr "\n" " " | clip.exe 
}

function yy() {
    echo $1 | tr "\n" " " | clip.exe 
    CLIP=$1
}

function cat ()
{
  # If the first argument is a pdf file, use pdftotext command
  # Else, use bat command
  
  if [[ $1 == *.pdf ]]; then
    pdftotext $1 - | bat
  elif [[ $1 == *.docx ]]; then
    textutil -stdout -cat txt $1 | bat
  else
    bat $@
  fi
}

function cpath() {
  # If there are no arguments
  if [[ $# -eq 0 ]]; then
    # Copy the current path
    echo $(pwd) | tr "\n" " " | pbcopy
  else
    # Copy the path of the first argument
    echo $(realpath $1) | tr "\n" " " | pbcopy
  fi
}

function create_latex_homework()
{
  if [[ -z $1 ]]; then
    cp ~/.dotfiles/.local/share/template.tex .
  else
    cp ~/.dotfiles/.local/share/template.tex $1
  fi
}

function c(){
  gcc -Wall $1 && ./a.out && rm a.out
}

function code()
{
  if [[ -z $1 ]]; then
    open . -a Visual\ Studio\ Code\ -\ Insiders.app
  else
    open $1 -a Visual\ Studio\ Code\ -\ Insiders.app
    
  fi
}

function trash ()
{
  if [[ -z $@ ]]; then
    cd $HOME/.Trash/
  else
    mv $@ $HOME/.Trash/
  fi
}

function what-the-shell ()
{
  source $HOME/.dotfiles/github-cli/lazy-load.sh
  copilot_what-the-shell $@
}

function git-assist ()
{
  source $HOME/.dotfiles/github-cli/lazy-load.sh
  copilot_git-assist $@
}

function gh-assist ()
{
  source $HOME/.dotfiles/github-cli/lazy-load.sh
  copilot_what-the-shell $@
}

function docker_start ()
{
  sudo ln -s ~/Library/Containers/com.docker.docker/Data/docker.raw.sock /var/run/docker.sock
  DOCKER_HOST=unix:///var/run/docker.sock docker ps # test that it works using linked socket file
}
