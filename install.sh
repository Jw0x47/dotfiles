#!/bin/bash

#################
# Flag Handling #
#################

S=0
g=0

# define function to explain use of program
function usage () {
  echo 'JWGs dotfile install script'
  echo 'Can only be run in ~/.dotfiles'
  echo '-S : use sudo'
  echo '-g : run gem install(s)'
  echo '-h : show this message'
}

# Flags / Options parsing
while getopts Sgh OPT; do
  case "$OPT" in
    S) S=1;;
    g) g=1;;
    h) usage;;
    *) # getopts produces error
      exit 1;;
  esac
done

# Function that does some initial setup
function install_start () {
  echo This script is destructive. If you have dotfiles you care about, please exit and save them.
  echo -n "Continue? [y/n] "
  read ans
  if [ "$ans" == "y" ]; then
    if [ $(pwd) == "$HOME/.dotfiles" ];then
      echo "Starting ...."
    else
      echo "$(tput setaf 1)FAILURE:$(tput sgr 0) Execute this from within your .dotfiles folder in $HOME/./dotfiles"
      exit 1
    fi
  else
    echo Quitting per user
    exit 1
  fi
}

install_start

# Function that handles gem-installs
function gem_install () {
  program=$1
  echo Starting install of $program
  where=$(which $program | head -c 1)
  if [ $where == '/' ]
  then
    echo "$(tput setaf 2)Success:$(tput sgr 0) $program already installed!";
  else
    case "$g$S" in
      00) echo 'Gem not installed, also not installing';; # No sudo no install
      01) echo 'Gem not installed, also not installing';; # No sudo no install
      10) echo 'Installing Gem w/o sudo' gem install $program ;;
      11) echo 'Insatlling Gem with sudo' sudo gem install $program ;;
  esac
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
  echo Installing Homebrew Programs
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
echo 'Clobbering dotfiles'
ls |grep -v install | xargs -I {} rm -rf ~/.{}
# Link in our own over those
echo 'Installing jwg dotfiles'
ls |grep -v install | xargs -I {} ln -s $(pwd)/{} ~/.{}

# Install all bundles (vim bundler)
echo 'Vim Bundle Install'
vim +BundleInstall +qall
echo Done...
