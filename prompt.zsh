#  ____                            _   
# |  _ \ _ __ ___  _ __ ___  _ __ | |_ 
# | |_) | '__/ _ \| '_ ` _ \| '_ \| __|
# |  __/| | | (_) | | | | | | |_) | |_ 
# |_|   |_|  \___/|_| |_| |_| .__/ \__|
#                           |_|        

# Load version control information
autoload -Uz vcs_info

precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats " %{$fg_bold[yellow]%}[%b]"
 
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT="%B%{$fg_bold[red]%}[%n] %{$fg_bold[cyan]%}[%1d]" 
PROMPT+="\$vcs_info_msg_0_ ⚡"
