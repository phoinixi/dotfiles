#!/usr/bin/env zsh
# Symlink Zed editor config.

source "${DOTFILES_DIR}/install/lib.sh"

link_file "${DOTFILES_DIR}/zed/settings.json" "$HOME/.config/zed/settings.json"
link_file "${DOTFILES_DIR}/zed/keymap.json"   "$HOME/.config/zed/keymap.json"
