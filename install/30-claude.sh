#!/usr/bin/env zsh
# Provision the Claude Code agent harness at ~/.claude.
#
# First run on a machine with an existing ~/.claude/settings.json:
#   - Diffs live permissions.allow against the tracked (sanitized) one.
#   - Writes the difference (per-project / machine-local entries) to
#     ~/.claude/settings.local.json — Claude Code merges that with the
#     symlinked settings.json, so no allowlist entries are lost.
#   - Then backs up the original to settings.json.bak and symlinks the
#     tracked file.
# Subsequent runs are idempotent: the file is already a symlink, no migration.

source "${DOTFILES_DIR}/install/lib.sh"

if ! command -v claude >/dev/null 2>&1; then
  e_warning "claude CLI not found. install/50-node.sh installs it via npm."
fi

mkdir -p "$HOME/.claude/plugins"

LIVE="$HOME/.claude/settings.json"
LOCAL="$HOME/.claude/settings.local.json"
TRACKED="${DOTFILES_DIR}/claude/settings.json"

# Migrate non-generic permissions from a real (non-symlink) live settings file
# into settings.local.json so they survive the symlink swap.
if [ -e "$LIVE" ] && [ ! -L "$LIVE" ]; then
  if ! command -v jq >/dev/null 2>&1; then
    e_warning "jq not installed — skipping settings migration. Install jq and re-run."
  else
    EXTRA=$(jq -n \
      --slurpfile live "$LIVE" \
      --slurpfile tracked "$TRACKED" \
      '(($live[0].permissions.allow // []) - ($tracked[0].permissions.allow // []))')
    EXTRA_COUNT=$(jq 'length' <<<"$EXTRA")

    if [ "$EXTRA_COUNT" -gt 0 ]; then
      e_arrow "Migrating ${EXTRA_COUNT} per-project permission(s) into settings.local.json"
      if [ -f "$LOCAL" ]; then
        jq --argjson extra "$EXTRA" '
          .permissions = (.permissions // {})
          | .permissions.allow = ((.permissions.allow // []) + $extra | unique)
        ' "$LOCAL" > "${LOCAL}.tmp" && mv "${LOCAL}.tmp" "$LOCAL"
      else
        jq -n --argjson extra "$EXTRA" '{permissions: {allow: $extra}}' > "$LOCAL"
      fi
      e_success "Wrote $LOCAL"
    else
      e_success "No per-project permissions to migrate."
    fi
  fi
fi

# Symlinks (link_file backs up any existing real file to <path>.bak).
link_file "${DOTFILES_DIR}/claude/settings.json"            "$HOME/.claude/settings.json"
link_file "${DOTFILES_DIR}/claude/CLAUDE.md"                "$HOME/.claude/CLAUDE.md"
link_file "${DOTFILES_DIR}/claude/agents"                   "$HOME/.claude/agents"
link_file "${DOTFILES_DIR}/claude/commands"                 "$HOME/.claude/commands"
link_file "${DOTFILES_DIR}/claude/hooks"                    "$HOME/.claude/hooks"
link_file "${DOTFILES_DIR}/claude/output-styles"            "$HOME/.claude/output-styles"
link_file "${DOTFILES_DIR}/claude/plugins/installed_plugins.json" "$HOME/.claude/plugins/installed_plugins.json"
