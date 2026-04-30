#!/usr/bin/env zsh
# Symlink global git config, gitignore, and editorconfig.

source "${DOTFILES_DIR}/install/lib.sh"

link_file "${DOTFILES_DIR}/git/.gitconfig"        "$HOME/.gitconfig"
link_file "${DOTFILES_DIR}/git/.gitignore_global" "$HOME/.gitignore_global"
link_file "${DOTFILES_DIR}/.editorconfig"         "$HOME/.editorconfig"
