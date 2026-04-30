#!/usr/bin/env zsh
# Common helpers sourced by every install/*.sh module.
# Modules are sourced (not exec'd) by install.sh, so DOTFILES_DIR and
# the e_* helpers from utils/utils.sh are already in scope.

# link_file SRC DST
#   Idempotent symlink. Backs up an existing real file or differing symlink
#   to ${DST}.bak. Refuses to clobber a path matching $PROTECT_GLOB.
link_file() {
  local src="$1"
  local dst="$2"

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
      e_success "Symlink already correct: $dst"
      return 0
    fi
    e_arrow "Backing up: $dst -> ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi

  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  e_success "Linked: $dst -> $src"
}
