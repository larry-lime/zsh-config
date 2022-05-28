#!/usr/bin/zsh
#███████╗██╗░░░██╗███╗░░██╗░█████╗░████████╗██╗░█████╗░███╗░░██╗░██████╗
#██╔════╝██║░░░██║████╗░██║██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║██╔════╝
#█████╗░░██║░░░██║██╔██╗██║██║░░╚═╝░░░██║░░░██║██║░░██║██╔██╗██║╚█████╗░
#██╔══╝░░██║░░░██║██║╚████║██║░░██╗░░░██║░░░██║██║░░██║██║╚████║░╚═══██╗
#██║░░░░░╚██████╔╝██║░╚███║╚█████╔╝░░░██║░░░██║╚█████╔╝██║░╚███║██████╔╝
#╚═╝░░░░░░╚═════╝░╚═╝░░╚══╝░╚════╝░░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░

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
        jobs
    else
        fg %$1
    fi
}

function take() {
    mkdir -p -- "$1" &&
    cd -P -- "$1"
    echo $(pwd) | tr "\n" " " | clip.exe 
    CLIP=$(pwd)
}

function go() {
    FILE=$1
    CHECK="${FILE##*.}"
    if [[ ! -f $1 ]] then
        touch $1
    fi
    if [ "$CHECK" = "md" ]; then
        nvim $FILE
    elif [ "$CHECK" = "pdf" ]; then
        SumatraPDF.exe $FILE
    elif [ "$CHECK" = "docx" ]; then
        winword.exe $FILE
    elif [ "$CHECK" = "html" ]; then
        brave.exe $FILE
    elif [ "$CHECK" = "xslx" ]; then
        excel.exe $FILE
    elif [ "$CHECK" = "xlsm" ]; then
        excel.exe $FILE
    elif [ "$CHECK" = "xlsx" ]; then
        excel.exe $FILE
    elif [ "$CHECK" = "csv" ]; then
        excel.exe $FILE
    elif [ "$CHECK" = "py" ]; then
        nvim $FILE
    elif [ "$CHECK" = "txt" ]; then
        nvim $FILE
    else
        echo "Not working yet bro"
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

function mknote() {
    FILE="$1.md"
    if test -f "$FILE"; then
        nvim $FILE
    else
        touch $FILE
        echo "# $1" >> $FILE
        nvim $FILE
    fi
}

# -----------------------------------------------------------------
# Personal Plugins
# -----------------------------------------------------------------
# TODO Code more interesting plugins and expand on the ones that I have

function journal() {
    cd /mnt/c/Users/larry/OneDrive/Documents/'Journal Entries'
    DATE=$(date +%F)
    FILE="journal_entry_${DATE}.md"
    if [[ -f "$FILE" ]]; then
        nvim $FILE
    else
        touch $FILE
        echo "# Journal Entry ${DATE}\n" >> $FILE
        nvim $FILE
    fi
}

function proj() {
    cd "/mnt/c/Users/larry/life_design/Projects/"
    nvim "projects.md"
}

function stodo() {
    DATE=$(date +%F)
    FILE="todo_${DATE}.md"
    VAR="/mnt/c/Users/larry/life_design/to_do/$FILE"
    if [[ -f "$VAR" ]]; then
        glow $VAR
    else
        echo "Today's todo has not been created yet"
    fi
}

# TODO Look to improve this and the journal plugin
# Make it so that the files that are created are organized in to folders by year and month
function todo() {
    cd /mnt/c/Users/larry/life_design/to_do
    DATE=$(date +%F)
    FILE="todo_${DATE}.md"
    if [[ -f "$FILE" ]]; then
        nvim $FILE
    else
        touch $FILE
        TEMPLATE="# Daily To-Do ${DATE} \n"
        TEMPLATE+="\n## ACADEMICS\n"
        TEMPLATE+="- [ ] \n"
        TEMPLATE+="\n## WORK\n"
        TEMPLATE+="- [ ] \n"
        TEMPLATE+="\n## PERSONAL\n"
        TEMPLATE+="- [ ] \n"
        TEMPLATE+="\n## OTHER\n"
        TEMPLATE+="- [ ] \n"
        echo "$TEMPLATE" >> $FILE
        nvim $FILE
    fi
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

function clip()
{
    echo $CLIP
}

function vimcal(){
    nvim -c ":Calendar"
}

function vimclock(){
    nvim -c ":Calendar -view=clock"
}

function cpode() {
    powershell.exe -c "code $1"
}

function jlab() {
    powershell.exe -c "conda activate ; jupyter-lab $1"
}

function btm() { 
    powershell.exe -c "btm"
}

function ngstart() {
    powershell.exe -c "ngrok tcp --region jp $1"
}

function nv() {
    if [ $# -eq 0 ]; then
        nvim -c ":call LoadSession('lastsession.vim') | :NERDTree"
    else
        nvim $1
    fi
}

# -----------------------------------------------------------------
# Git Features
# -----------------------------------------------------------------

function git_start() {
    # Copy Token
    TOKEN=$(cat /mnt/c/Users/larry/nyu/ics/git_learn/token.txt)
    echo $TOKEN | tr -d '[:space:]' | clip.exe 
    git init
    git commit -m "first commit"
    git branch -M main
    git remote add origin $1
    git push -u origin main
}

function gopen() {
    brave.exe $(git config --get remote.origin.url)
}

function lg() {
    TOKEN=$(cat /mnt/c/Users/larry/nyu/ics/git_learn/token.txt)
    echo $TOKEN | tr -d '[:space:]' | clip.exe 
    lazygit
}
