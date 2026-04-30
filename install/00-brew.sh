#!/usr/bin/env zsh
# Install or update Homebrew, then run brew bundle from the repo Brewfile.

if ! command -v brew >/dev/null 2>&1; then
  e_arrow "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  e_success "Homebrew installed"
else
  e_arrow "Updating Homebrew..."
  brew update
  e_success "Homebrew updated"
fi

e_arrow "Running brew bundle..."
set +e
brew bundle install --file="${DOTFILES_DIR}/Brewfile"
local rc=$?
set -e
if [ $rc -ne 0 ]; then
  e_warning "brew bundle exited with $rc — review output above"
else
  e_success "Brewfile dependencies installed"
fi
