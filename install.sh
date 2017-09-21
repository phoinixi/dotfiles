#!/bin/bash

# GIT
header "Setting up GIT"
cp git/.gitignore ~/.gitignore_global
cp git/.gitconfig ~/.gitconfig
git config --global core.excludesfile "${HOME}/.gitignore_global"

# BREW
if test ! $(which brew); then
  header "Installing Homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  header "Updating Homebrew"
  brew update
fi

# checks if apple ID was used as argument, if not ask for it
if [ $# -eq 0 ]
  then
    ask ' Enter your AppleID:'
    read APPLEID
else
    APPLEID=$1
fi

brew install mas

mas signout
header '🍎 Signing in with your appleID'
mas signin --dialog $APPLEID
mas upgrade

header 'Next time you are asked for you password, enter you system passowrd'

# run Brewfile
brew tap Homebrew/bundle
brew bundle

source utils/utils.sh
header "Installing Oh my zsh!"
source oh-my-zsh/index.sh
header "Setting up mac os X"
source osx/index.sh
header "Setting VSCODE"
source vscode/index.sh

sudo sh -c “softwareupdate -ia && reboot”

success "Your mac is going to reboot..."
thanks "Author: https://github.com/francescoes \n"
