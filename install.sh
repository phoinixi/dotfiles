#!/usr/bin/env zsh
set -e

DOTFILES_DIR=$(pwd)

ZSH_CUSTOM="$HOME/.oh-my-zsh"

source "${DOTFILES_DIR}/utils/utils.sh"

# Usage: link_file source_path target_path
link_file() {
  local source="$1"
  local target="$2"

  # If target exists
  if [ -e "$target" ]; then
    # If target is already a symlink to the source, do nothing
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
      e_success "Symlink already exists: $target -> $source"
      return 0
    fi
    # If it's a different file or symlink, back it up
    e_arrow "Backing up existing file: $target to ${target}.bak"
    mv "$target" "${target}.bak"
  fi

  e_arrow "Creating symlink: $target -> $source"
  ln -s "$source" "$target"
  e_success "Symlink created: $target -> $source"
}

# --- Main Setup Logic ---

# Install/Update Homebrew
e_header "Checking Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
  e_arrow "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add brew to PATH for the current script execution (especially on Apple Silicon)
  eval "$(/opt/homebrew/bin/brew shellenv)"
e_success "Homebrew installed."
else
  e_arrow "Updating Homebrew..."
  brew update
  e_success "Homebrew updated."
fi

# Install dependencies from Brewfile
e_header "Installing dependencies from Brewfile..."
# Temporarily disable exit-on-error for brew bundle
set +e
brew bundle install --file="${DOTFILES_DIR}/Brewfile"
BREW_BUNDLE_EXIT_CODE=$?
# Re-enable exit-on-error
set -e

if [ $BREW_BUNDLE_EXIT_CODE -ne 0 ]; then
  e_warning "Brew bundle install finished with errors. Some packages/casks might have failed."
  e_warning "Please review the output above for details."
else
  e_success "Brewfile dependencies installed successfully."
fi

# Install Oh My Zsh
e_header "Checking Oh My Zsh..."
if [ ! -d "$ZSH_CUSTOM" ]; then
  e_arrow "Installing Oh My Zsh..."
  # Use the official installer script
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  e_success "Oh My Zsh installed."
else
  e_success "Oh My Zsh already installed."
fi
# Note: The OMZ installer might create a default ~/.zshrc, which we'll overwrite next.

# Create symlinks
e_header "Creating symlinks..."

# Zsh config
link_file "${DOTFILES_DIR}/.zshrc" "$HOME/.zshrc"

# Git config & ignore
link_file "${DOTFILES_DIR}/git/.gitconfig" "$HOME/.gitconfig"
link_file "${DOTFILES_DIR}/git/.gitignore_global" "$HOME/.gitignore_global"

# Editor config
link_file "${DOTFILES_DIR}/.editorconfig" "$HOME/.editorconfig"

# Set up Node.js using FNM
e_header "Setting up Node.js via FNM..."
# Ensure fnm is available in the current shell context (might need eval)
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell zsh)" # Ensure FNM env is loaded
  fnm install --lts
  fnm default lts-latest # Set the installed LTS as default
  fnm use default
  e_success "Node.js LTS installed and set as default via FNM."
else
  e_error "FNM command not found. Please check Brewfile installation."
fi

# Apply macOS settings
e_header "Applying macOS settings..."
# Check if osx/index.sh exists before sourcing
if [ -f "${DOTFILES_DIR}/osx/index.sh" ]; then
  (cd "${DOTFILES_DIR}/osx" && source index.sh)
  e_success "macOS settings applied."
else
  e_warning "${DOTFILES_DIR}/osx/index.sh not found. Skipping macOS settings."
fi

e_header "Setup Complete!"
e_success "Please restart your terminal or source ~/.zshrc for all changes to take effect."

e_thanks "Author: https://github.com/phoinixi"

exit 0
