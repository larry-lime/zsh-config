# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
#export ZSH="$HOME/.oh-my-zsh"
export ZDOTDIR=$HOME/.config/zsh
export MPLBACKEND=TKAgg
#export DISPLAY=localhost:0.0
#export DISPLAY=`grep -oP "(?<=nameserver ).+" /etc/resolv.conf`:0.0

# Colors and Style
autoload -Uz colors && colors
zstyle ':completion:*' menu select

source "$ZDOTDIR/functions.zsh"
# Source Files
#source "/home/larrylime/.config/zsh/final_project_testing.zsh "

zsh_add_file "prompt.zsh"
zsh_add_file "vim-mode.zsh"
zsh_add_file "aliases.zsh"
zsh_add_file "final_project_testing.zsh"

zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-autosuggestions"

export EDITOR="nvim"
export BROWSER="brave.exe"

# ZSH_HIGHLIGHT_STYLES
#(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[path]=none
#ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/larrylime/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
__conda_setup="$('/home/larrylime/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/larrylime/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/larrylime/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/larrylime/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# Neofetch: Terminal SplashScreen
#neofetch

# Display random messages
#fortune

# Cowsay: Create eye-catchy splash screen prompts
#fortune | cowsay
#fortune | cowsay -f dragon

#figlet utility to convert normal text to ASCII art
#figlet -cl "larrylime"
#/home/larrylime/.yarn/bin
#warning: be sure to add `/home/larrylime/.cargo/bin` to your PATH to be able to run the installed binaries
PATH="$PATH:/home/larrylime"
PATH="$PATH:/home/larrylime/.cargo/bin"
