#     ____                             __ 
#    / __ \_________  ____ ___  ____  / /_
#   / /_/ / ___/ __ \/ __ `__ \/ __ \/ __/
#  / ____/ /  / /_/ / / / / / / /_/ / /_  
# /_/   /_/   \____/_/ /_/ /_/ .___/\__/  
#                           /_/

# -----------------------------------------------------------------
# Prompt inspired by chris@machine
# -----------------------------------------------------------------
# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats " %{$fg_bold[yellow]%}[%b]"
 
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT="%B%{$fg_bold[red]%}[%n] %{$fg_bold[cyan]%}[%1d]" 
PROMPT+="\$vcs_info_msg_0_ » "
#PROMPT+="\$vcs_info_msg_0_ ⚡"
#RPS1="%{$fg_bold[white]%}[%m]"
