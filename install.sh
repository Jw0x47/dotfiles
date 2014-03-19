#!/bin/bash

if [ $(pwd) == "$HOME/.dotfiles" ];then
  echo "Starting .... "
else
  echo "$(tput setaf 1)FAILURE:$(tput sgr 0) Execute this from within your .dotfiles folder in $HOME/./dotfiles"
  exit 1
fi

function gem_install () {
  program=$1
  echo Starting install of $program
  where=$(which $program | head -c 1)
  if [ $where == '/' ]
  then
    echo "$(tput setaf 2)Success:$(tput sgr 0) $program already installed!";
  else
    sudo gem install $program
  fi

}

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
  # we let these error / update
  brew install \
    wget \
    fortune \
    cowsay \
    vim # Yes we install vim... basically the vim that ships on macos doesn't support my dotfiles (ansible)

  # Check if puppet is installed
  gem_install 'puppet'
  gem_install 'i2cssh'
fi

#####################
# OS Neutral Things #
#####################
gem_install 'puppet-lint'


# Install Dotfiles
# Remove any dotfiles that we're clobbering
ls |grep -v install | xargs -I {} rm -rf ~/.{}
# Link in our own over those
ls |grep -v install | xargs -I {} ln -s $(pwd)/{} ~/.{}

# Install all bundles (vim bundler)
echo 'Vim Bundle Install'
vim +BundleInstall +qall
echo Done...
