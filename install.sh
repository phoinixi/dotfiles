#!/usr/bin/env zsh
set -eu

DOTFILES_DIR="${DOTFILES_DIR:-$(cd -- "$(dirname -- "${(%):-%x}")" && pwd)}"
export DOTFILES_DIR

# shellcheck source=utils/utils.sh
source "${DOTFILES_DIR}/utils/utils.sh"

# Modules in execution order. Filename prefix encodes order.
MODULES=(
  "00-brew"
  "10-shell"
  "20-git"
  "30-claude"
  "40-zed"
  "45-ghostty"
  "50-node"
  "55-raycast"
  "60-macos"
)

usage() {
  cat <<'EOF'
Usage: install.sh [--only <module>] [--list] [--help]

  --only <module>   Run only the named module (e.g. claude, zed, brew).
                    Match is by suffix after the numeric prefix.
  --list            List available modules and exit.
  --help            Show this help.

Examples:
  install.sh                     # run everything
  install.sh --only claude       # re-symlink ~/.claude harness only
  install.sh --only zed          # re-symlink ~/.config/zed only
EOF
}

list_modules() {
  for m in "${MODULES[@]}"; do
    printf '  %s\n' "${m#*-}"
  done
}

ONLY=""
while [ $# -gt 0 ]; do
  case "$1" in
    --only)
      ONLY="${2:-}"
      shift 2
      ;;
    --list)
      list_modules
      exit 0
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      e_warning "Unknown argument: $1"
      usage
      exit 1
      ;;
  esac
done

run_module() {
  local module_file="$1"
  local module_path="${DOTFILES_DIR}/install/${module_file}.sh"
  if [ ! -f "$module_path" ]; then
    e_warning "Module not found: $module_path"
    return 1
  fi
  e_header "Module: ${module_file}"
  # shellcheck disable=SC1090
  source "$module_path"
}

if [ -n "$ONLY" ]; then
  matched=""
  for m in "${MODULES[@]}"; do
    if [ "${m#*-}" = "$ONLY" ]; then
      matched="$m"
      break
    fi
  done
  if [ -z "$matched" ]; then
    e_warning "No module matches --only $ONLY"
    e_warning "Available modules:"
    list_modules
    exit 1
  fi
  run_module "$matched"
else
  for m in "${MODULES[@]}"; do
    run_module "$m"
  done
fi

e_header "Setup complete"
e_success "Restart your terminal or run: source ~/.zshrc"
e_thanks "Author: https://github.com/phoinixi"
