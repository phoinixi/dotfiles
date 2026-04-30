#!/usr/bin/env zsh
# Apply macOS defaults from osx/index.sh.

if [ -f "${DOTFILES_DIR}/osx/index.sh" ]; then
  ( cd "${DOTFILES_DIR}/osx" && source index.sh )
  e_success "macOS settings applied"
else
  e_warning "osx/index.sh not found — skipping"
fi
