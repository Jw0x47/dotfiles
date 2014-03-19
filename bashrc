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


###########
# Aliases #
###########
alias ls="ls --color=auto"
