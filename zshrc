# load our own completion functions
fpath=(~/.zsh/completion $fpath)
# hubspot bullshit
fpath=(/opt/boxen/homebrew/share/zsh/site-functions $fpath)

[ -n "$XTERM_VERSION" ] && transset-df -a >/dev/null

# completion
autoload -U compinit
compinit

for function in ~/.zsh/functions/*; do
  source $function
done

# automatically enter directories without cd
setopt auto_cd

# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# use incremental search
bindkey "^R" history-incremental-search-backward

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# handy keybindings
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# ignore duplicate history entries
setopt histignoredups
setopt inc_append_history
setopt share_history

# keep TONS of history
export HISTSIZE=4096
export SAVEHIST=4096
export HISTFILE=~/.zsh_history

# automatically pushd
setopt auto_pushd
export dirstacksize=5

# awesome cd movements from zshkit
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt cdablevars

# Try to correct command line spelling
setopt CORRECT CORRECT_ALL

# Enable extended globbing
setopt EXTENDED_GLOB

# Allow [ or ] whereever you want
unsetopt nomatch

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# adds the current branch name in green
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]"
  fi
}

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# expand functions in the prompt
setopt prompt_subst

# prompt
export PS1='$(git_prompt_info)[${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%~%{$reset_color%}] '

# load dotfiles scripts (daily)
export PATH="/Users/jgoodwin/Library/Python/2.7/bin:$HOME/.bin:$PATH"
daily
welcome

# Powerline
# source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh/
source /Users/jgoodwin/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh

source ~/.zshrc.development
[ -f /Users/jgoodwin/.profile ] && source /Users/jgoodwin/.profile
