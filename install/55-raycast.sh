#!/usr/bin/env zsh
# Raycast: reminder-only step. There's no clean tracked config — see raycast/README.md.

if [ -f "${DOTFILES_DIR}/raycast/extensions.txt" ]; then
  e_note "Raycast extensions to install (see raycast/extensions.txt):"
  grep -vE '^\s*(#|$)' "${DOTFILES_DIR}/raycast/extensions.txt" | sed 's/^/    - /'
  e_note "Open Raycast Settings → Cloud Sync for snippets/quicklinks/aliases."
fi
