#     ______                 __  _                 
#    / ____/_  ______  _____/ /_(_)___  ____  _____
#   / /_  / / / / __ \/ ___/ __/ / __ \/ __ \/ ___/
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

function cpath() {
    echo $(pwd) | tr "\n" " " | clip.exe 
    CLIP=$(pwd)
}

function copy() {
    echo $1 | tr "\n" " " | clip.exe 
}

function generateREADMe() {
    echo $1 | tr "\n" " " | clip.exe 
}

# -----------------------------------------------------------------
# Terminal Applications & Tools
# -----------------------------------------------------------------

function cow(){ # Cowsay: Create eye-catchy splash screen prompts
    fortune | cowsay
}

function dragon(){ 
    fortune | cowsay -f dragon
}

function user(){ #figlet utility to convert normal text to ASCII art
    figlet -cl "larrylime"
}

function cpode() {
    powershell.exe -c "code $1"
}

function btm() { 
    powershell.exe -c "btm"
}

# -----------------------------------------------------------------
# Git Features
# -----------------------------------------------------------------

function gopen() {
    /mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe $(git config --get remote.origin.url)
}

