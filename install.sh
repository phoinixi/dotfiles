
#!/bin/sh
source utils/utils.sh

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

e_header 'Next time you are asked for you password, enter you system passowrd'

# run Brewfile
e_header "Run Brewfile!"
brew tap Homebrew/bundle
brew bundle
e_success "brew and cask done!"

e_header "Setting GIT"
(cd git ; source index.sh)
e_success "GIT setup done!"

e_header "Setting Oh my zsh"
(cd oh-my-zsh ; source index.sh)
e_success "Oh my zsh installed!"

e_header "Setting up nodejs"
fnm  install --lts
e_success "node setup done!"

e_header "Setting up mac os X"
(cd osx ; source index.sh)
e_success "OSX settings done!"

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

e_thanks "Author: https://github.com/phoinixi \n"
