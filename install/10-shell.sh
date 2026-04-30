#!/usr/bin/env zsh
# Install Oh My Zsh (if missing) and symlink .zshrc.

source "${DOTFILES_DIR}/install/lib.sh"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  e_arrow "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  e_success "Oh My Zsh installed"
else
  e_success "Oh My Zsh already installed"
fi

link_file "${DOTFILES_DIR}/.zshrc" "$HOME/.zshrc"
