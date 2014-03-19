
if [[ -n $SSH_TTY ]];then
  ssh_user="\u@\h "
fi
PS1="[$(tput setaf 1)$ssh_user\w$(tput sgr0)] "

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3)
  if [[ -n $ref ]]; then
    # Zsh prompt this was based on
    # echo "[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]"
    echo "[$(tput setaf 2)$ref$(tput sgr0)]"
  fi
}


export PS1="\$(git_prompt_info)$PS1"
