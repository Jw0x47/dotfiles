#!/bin/bash

if [ $(pwd) == "$HOME/.dotfiles" ];then
  echo "Starting .... "
else
  echo "$(tput setaf 1)FAILURE:$(tput sgr 0) Execute this from within your .dotfiles folder in $HOME/./dotfiles"
  exit 1
fi

## TOTAL BULLSHIT !!!
#brew tap mike-burns/rcm
#brew install rcm
#rcup -d ~/.dotfiles -x README.md -x LICENSE

# Fuck that noise;
# HERE WE GOOO

##########################################
# Macs need things (they're also Darwin) #
##########################################
if [ $(uname) == 'Darwin' ];then
  # Check if Brew is installed
  # If its not... install brew stuff

  if brew -h &> /dev/null; then
    echo "$(tput setaf 2)Warning:$(tput sgr 0) No brew; installing Homebrew..."
    # Install homebrew
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"
  fi
  # Then install our shits
  brew install \
    wget \
    fortune \
    cowsay \
    vim

  # Check if puppet is installed
  if which puppet &> /dev/null; then gem install puppet; fi

fi

#####################
# OS Neutral Things #
#####################
if which puppet-lint &> /dev/null; then gem install puppet-lint; fi


# Install Dotfiles
# Remove any dotfiles that we're clobbering
ls |grep -v install | xargs -I {} rm -f ~/.{}
# Link in our own over those
ls |grep -v install | xargs -I {} ln -s $wd/{} ~/.{}

# Install all bundles (vim bundler)
vim +BundleInstall +qall

