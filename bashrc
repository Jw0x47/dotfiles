# Add username@host for SSH only
if [[ -n $SSH_TTY ]];then
  ssh_user="\u@\h "
fi

# Basic Prompt [username@host ~/working/dir]
# username@host is optional
PS1="[$(tput setaf 1)$ssh_user\w$(tput sgr0)] "

# function that checks if we're in git / returns git prompt data
function git_prompt_info() {
ref=$(git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3)
if [[ -n $ref ]]; then
  # Zsh prompt this was based on
  # echo "[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]"
  echo "[$(tput setaf 2)$ref$(tput sgr0)]"
fi
}

# Final Prompt; pre-appending git prompt data
export PS1="\$(git_prompt_info)$PS1"

export SHAFT=1
function shaftRandom() {

}

# prompt() {
#   shaftExtender
#   PS1="8"$SHAFT"D "
# }
#
# PROMPT_COMMAND=prompt

# export PS1="\$(shaftExtender)"

###########
# Aliases #
###########
if [ $(uname) == 'Darwin' ];then
  alias ls="ls -G"
else
  alias ls="ls --color=auto"
fi

