#!/usr/bin/env zsh
# Symlink Ghostty terminal config.

source "${DOTFILES_DIR}/install/lib.sh"

link_file "${DOTFILES_DIR}/ghostty/config" "$HOME/.config/ghostty/config"
