# If you come from bash you might have to change your $PATH.
export ZDOTDIR=$HOME/.config/zsh

# Colors and Style
autoload -Uz colors && colors
zstyle ':completion:*' menu select

source "$ZDOTDIR/functions.zsh"
# Source Files
zsh_add_file "prompt.zsh"
zsh_add_file "vim-mode.zsh"
zsh_add_file "aliases.zsh"
zsh_add_file "temp.zsh"
zsh_add_file "fzf.zsh"
zsh_add_file "keybinds.zsh"

zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-autosuggestions"

export EDITOR="nvim"
export BROWSER="brave.exe"

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

#warning: be sure to add `/home/larrylime/.cargo/bin` to your PATH to be able to run the installed binaries
# PATH="$PATH:/home/larrylime"
# PATH="$PATH:/home/larrylime/.cargo/bin"

export GOROOT=/usr/local/go-1.18.2
export GOPATH=$HOME/projects/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.npm-global/bin
