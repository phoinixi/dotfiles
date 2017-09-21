source utils/utils.sh
e_header "Installing Oh my zsh!"
source oh-my-zsh/index.sh
e_header "Setting up mac os X"
source osx/index.sh
e_header "Setting VSCODE"
source vscode/index.sh

# GIT
e_header "Setting up GIT"
cp git/.gitignore ~/.gitignore_global
cp git/.gitconfig ~/.gitconfig
git config --global core.excludesfile "${HOME}/.gitignore_global"

# BREW
if test ! $(which brew); then
  e_header "Installing Homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  e_header "Updating Homebrew"
  brew update
fi

# NODE
if test ! $(which node); then
  e_header "Installing NodeJS"
  brew install node

  # To setup npm install/update -g without sudo
  cp npmrc ~/.npmrc
  mkdir "${HOME}/.npm-packages"
  export PATH="$HOME/.node/bin:$PATH"
  sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}

  # Set npm global config
	read -r nodeAuthorName
	read -r nodeAuthorEmail
  npm config set init.author.name "$nodeAuthorName"
  npm config set init.author.email "$nodeAuthorEmail"
else
  e_header "Updating NodeJS"
  brew upgrade node
  npm install -g npm
fi

# YARN
if test ! $(which yarn); then
  e_header "Installing yarn"
  brew install yarn
else
  e_header "Updating yarn"
  brew upgrade yarn
fi

# Set the Application folder to the User
export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

# checks if apple ID was used as argument, if not ask for it
if [ $# -eq 0 ]
  then
    ask '${blue}  Enter your AppleID:'
    read APPLEID
else
    APPLEID=$1
fi

brew install mas

e_header '🍎 Signing in with your appleID'
mas signin --dialog $APPLEID
mas upgrade

e_header 'Next time you are asked for you password, enter you system passowrd'

# run Brewfile
brew tap Homebrew/bundle
brew bundle

e_thanks "Author: https://github.com/francescoes \n"

echo "Logout/restart to take effect."
