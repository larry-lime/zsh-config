# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats " %{$fg_bold[yellow]%}[%b]"
 
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
#PROMPT='%B%{$fg_bold[red]%}[%n] %{$fg_bold[magenta]%}[%m] %{$fg_bold[cyan]%}[%~] ${vcs_info_msg_0_} %{$fg_bold[white]%} » '
PROMPT="%B%{$fg_bold[red]%}[%n] %{$fg_bold[cyan]%}[%1d]" 
PROMPT+="\$vcs_info_msg_0_%{$fg_bold[white]%} » "
#RPS1="%{$fg_bold[white]%}[%m]"
#PROMPT='%n in ${PWD/#$HOME/~} ${vcs_info_msg_0_} > '
