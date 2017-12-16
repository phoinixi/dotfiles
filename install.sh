#!/bin/bash
source utils/utils.sh

# GIT
e_header "Setting up GIT"
cp git/.gitignore ~/.gitignore_global
cp git/.gitconfig ~/.gitconfig
git config --global core.excludesfile "${HOME}/.gitignore_global"
e_success "git config done!"

# BREW
if test ! $(which brew); then
  e_header "Installing Homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  e_header "Updating Homebrew"
  brew update
fi
e_success "brew updated done!"

# checks if apple ID was used as argument, if not ask for it
if [ $# -eq 0 ]
  then
    e_ask ' Enter your AppleID:'
    read APPLEID
else
    APPLEID=$1
fi

brew install mas

mas signout
e_header '🍎 Signing in with your appleID'
mas signin --dialog $APPLEID
mas upgrade
e_success "apple store apps upgrade done!"

e_header 'Next time you are asked for you password, enter you system passowrd'

# run Brewfile
e_header "Run Brewfile!"
brew tap Homebrew/bundle
brew bundle
e_success "brew and cask done!"

source oh-my-zsh/index.sh
e_success "Oh my zsh installed!"

e_header "Setting up mac os X"
source osx/index.sh
e_success "OSX settings done"

e_header "Setting VSCODE"
source vscode/index.sh
e_success "VSCODE setup done"

# Sotftware update
e_success "Launching software update..."
softwareupdate -ia

read -p "Do you want to reboot your mac? [y|N] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  exit 1
else 
  sudo reboot
fi

e_thanks "Author: https://github.com/francescoes \n"
