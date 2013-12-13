#!/bin/bash
# our working dir..
wd=`pwd`

if [ "$wd" == "$HOME/.dotfiles" ]
then
  echo "Starting .... "
else
  echo "FAILURE: Execute this from within your .dotfiles filder in $HOME"
  exit 1
fi

## TOTAL BULLSHIT !!!
#brew tap mike-burns/rcm
#brew install rcm
#rcup -d ~/.dotfiles -x README.md -x LICENSE

# Fuck that noise;
# HERE WE GOOO

if [ $# -ne 0 ]
then
  if [ $# -ne 1 ]
  then
    echo "FAILURE: Execute with MAC to deploy to Mac, otherwise leave blank"
    exit 1
  else
    OS=$1
  fi
else
  if [ "$OSTYPE" != "Linux-Gnu" ]
  then
    echo "This isn't a *nix system; or its a mac and you didn't say so. Try again with:          \`./install.sh MAC\`          Or you could fuck off."
    exit 1
  else
     OS='LINUX'
  fi
fi

####################
# Macs need things #
####################
if [ "$OS" == 'MAC' ]
then

  # Check if Brew is installed
  # If its not... install brew stuff
  brew -h &> /dev/null
  if [ $? -ne 0 ]
  then
    echo "no brew; installing homebrew"
    # Install homebrew
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"
  fi
  # We can always do this because it will just say "warning" if they're there
  brew install \
    wget \
    fortune \
    cowsay

  # Check if puppet is installed
  which puppet &> /dev/null
  if [ $? -ne 0 ]
  then
    gem install puppet
  fi
fi

# Puppet lint is cool
which puppet-lint &> /dev/null
if [ $? -ne "0" ]
then
  gem install puppet-lint
fi

# Install all bundles (vim bundler)
ls |grep -v install | xargs -I {} rm -f ~/.{}
ls |grep -v install | xargs -I {} ln -s $wd/{} ~/.{}
vim +BundleInstall +qall

