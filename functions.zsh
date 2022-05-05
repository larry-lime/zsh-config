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

# Invoke-Item 
function ii(){ 
    FILE=$1
    CHECK="${FILE##*.}"

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


# Write a function that adds file contents to the clipboard
function cfile(){
    # Function to add file contents to the clipboard
    if [ -f "$1" ]; then
        CLIP=$(cat $1)
        echo $CLIP | tr "\n" " " | clip.exe 
    else
        echo "File does not exist"
    fi
}

function yy()
{
    echo $1 | tr "\n" " " | clip.exe 
    CLIP=$1
}

# Copy pwd to clipboard and assign it to CLIP variable
function cpath(){
    echo $(pwd) | tr "\n" " " | clip.exe 
    CLIP=$(pwd)
}

# Create and open a markdown file with vim and accept a string as an argument
function mknote(){
    FILE="$1.md"
    if test -f "$FILE"; then
        nvim $FILE
    else
        touch $FILE
        echo "# $1" >> $FILE
        nvim $FILE
    fi
}
# Write a function that converts a camel case string to normal text
function camelcase(){
    echo $1 | sed -r 's/([A-Z])/ \1/g' | sed -r 's/^.//'
}

function journal(){
    cd /mnt/c/Users/larry/OneDrive/Documents/'Journal Entries'
    DATE=$(date +%F)
    FILE="journal_entry_${DATE}.md"
    if test -f "$FILE"; then
        nvim $FILE
    else
        touch $FILE
        echo "# Journal Entry ${DATE}\n" >> $FILE
        nvim $FILE
    fi
}

# Create and open a todo list in the to_do directory
function todo(){
    cd /mnt/c/Users/larry/life_design/to_do
    DATE=$(date +%F)
    FILE="todo_${DATE}.md"
    if test -f "$FILE"; then
        nvim $FILE
    else
        touch $FILE
        echo "# Daily To-Do ${DATE}\n
------------\n\
## ACADEMICS\n\
------------\n\
\n\
### ICS\n\
- [ ] \n
\n\
### STATS\n\
- [ ] \n 
\n\
### PSYCH\n\
- [ ] \n\
\n\
### WAI\n\
- [ ] \n
------------------\n\
## CAREER\n\
------------------\n\
- [ ]\n\
------------------\n\
## EXTRACURRICULAR\n\
------------------\n\
- [ ]\n\
------------------\n\
## OTHER\n\
------------------\n\
- [ ]\n\
            " >> $FILE
        nvim $FILE
    fi
}

# Cowsay: Create eye-catchy splash screen prompts
function cow(){
    fortune | cowsay
}

function dragon(){ 
    fortune | cowsay -f dragon
}

#figlet utility to convert normal text to ASCII art
function user(){
    figlet -cl "larrylime"
}

function clip()
{
    echo $CLIP
}

# Moves file or directory to file location in $CLIP and cds into that directory
function go()
{
    mv $1 $CLIP
    cd $CLIP
}

function in()
{
    cd $1 
    ls
}

function take()
{
    mkdir -p -- "$1" &&
    cd -P -- "$1"
    echo $(pwd) | tr "\n" " " | clip.exe 
    CLIP=$(pwd)
}

# Launch calendar.vim directly form terminal
function vimcal(){
    nvim -c ":Calendar"
}

# Launch calendar.vim in clock view directly form terminal
function vimclock(){
    nvim -c ":Calendar -view=clock"
}

# Project Testing
function ups()
{
    cd /mnt/c/Users/larry/nyu/ics/UP3/
    python3 /mnt/c/Users/larry/nyu/ics/UP3/chat_server.py
}
function upc()
{
    cd /mnt/c/Users/larry/nyu/ics/UP3/
    python3 /mnt/c/Users/larry/nyu/ics/UP3/chat_cmdl_client.py
}

#function copy_toke()
#{
    #'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' | clip.exe
#}
# Pwsh functions
function ppy
{
    powershell.exe -c "python3 $1"
}

# Git Functions
function gbranch()
{
    git branch $1
}

function gcheck()
{
    git checkout $1
}

function gpull()
{ 
    TOKEN=$(cat /mnt/c/Users/larry/nyu/ics/git_learn/token.txt)
    echo $TOKEN | tr -d '[:space:]' | clip.exe 
    git pull origin $1
}

function gpush()
{ 
    TOKEN=$(cat /mnt/c/Users/larry/nyu/ics/git_learn/token.txt)
    echo $TOKEN | tr -d '[:space:]' | clip.exe 
    git push -u origin $1
}

#function gclone()
#{ 
    #git clone $1
#}

function gcom()
{ 
    git commit -m "$1"
}

function glog()
{ 
    git log
}

function gadd()
{ 
    git add $1
}

function gmerge()
{ 
    git merge $1
}

function github()
{
    brave.exe 'https://github.com/larry-lime'
}

function git_start()
{
    # Copy Token
    TOKEN=$(cat /mnt/c/Users/larry/nyu/ics/git_learn/token.txt)
    echo $TOKEN | tr -d '[:space:]' | clip.exe 
    #echo "# python-fin-analysis" >> README.md
    touch README.md
    git init
    git add README.md
    git commit -m "first commit"
    git branch -M main
    git remote add origin $1
    git push -u origin main
}

