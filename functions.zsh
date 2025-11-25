#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/

# --------------
# PLUGIN MANAGER
# --------------

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

# -------------------
# CUSTOM ZSH COMMANDS
# -------------------

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

# FIXME: So this works on linux
function cpath() {
    # use pbcopy if on mac and xclip if on linux
    # if on macos, set the command to pbcopy elese set it to xclip
      [[ $OSTYPE == "darwin"* ]] && alias copy='pbcopy' || alias copy='xclip -selection clipboard'

      # if OS is macos, then copy the path of the current directory
      if [[ $# -eq 0 ]]; then
          echo $(pwd) | tr "\n" " " | pbcopy
      else
          if [[ -f $1 ]]; then
              echo $(pwd)/$1 | tr "\n" " " | pbcopy
          elif [[ -d $1 ]]; then
              echo $(pwd)/$1 | tr "\n" "/" | pbcopy
          fi
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

function cd ()
{
  builtin cd "$@" || return
  eza
  # echo $(pwd) | tr "\n" " " | pbcopy
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

function ghpr (){
# Parse arguments
draft_flag=""
base_branch=""
title=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --draft)
            draft_flag="--draft"
            shift
            ;;
        *)
            if [[ -z "$base_branch" ]]; then
                base_branch="$1"
            elif [[ -z "$title" ]]; then
                title="$1"
            fi
            shift
            ;;
    esac
done

# Create PR non-interactively (with optional draft flag)
gh pr create --base "$base_branch" --title "$title" $draft_flag --fill

# Find the latest PR from current branch
pr_number=$(gh pr list --state open --head "$(git branch --show-current)" --json number -q '.[0].number')

# Wait for CI checks to finish
gh pr checks --watch "$pr_number"
}


function kp() {
  port=$1
  kill $(lsof -t -i:$port)
}
