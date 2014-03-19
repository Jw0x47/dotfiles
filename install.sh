#!/bin/bash

if [ $(pwd) == "$HOME/.dotfiles" ];then
  echo "Starting .... "
else
  echo "$(tput setaf 1)FAILURE:$(tput sgr 0) Execute this from within your .dotfiles folder in $HOME/./dotfiles"
  exit 1
fi

##########################################
# Macs need things (they're also Darwin) #
##########################################
if [ $(uname) == 'Darwin' ];then
  # Check if Brew is installed
  # If its not... install brew stuff

  if brew -h &> /dev/null; then
    echo "$(tput setaf 2)Success:$(tput sgr 0) Homebrew already installed!"
  else
    echo "$(tput setaf 1)Warning:$(tput sgr 0) No brew; installing Homebrew..."
    # Install homebrew
    set -x
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"
    set +x
  fi

  # Then install our shits
  brew install \
    wget \
    fortune \
    cowsay \
    vim # Yes we install vim... basically the vim that ships on macos doesn't support my dotfiles (ansible)

  # Check if puppet is installed
  if which puppet &> /dev/null; then echo "$(tput setaf 2)Success:$(tput sgr 0) puppet already installed!" ;else gem install puppet; fi
fi

#####################
# OS Neutral Things #
#####################
if which puppet-lint &> /dev/null; then echo "$(tput setaf 2)Success:$(tput sgr 0) puppet-lint already installed!" ;else gem install puppet-lint; fi


# Install Dotfiles
# Remove any dotfiles that we're clobbering
ls |grep -v install | xargs -I {} rm -rf ~/.{}
# Link in our own over those
ls |grep -v install | xargs -I {} ln -s $(pwd)/{} ~/.{}

# Install all bundles (vim bundler)
vim +BundleInstall +qall

