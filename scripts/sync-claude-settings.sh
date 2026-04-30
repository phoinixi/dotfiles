#!/usr/bin/env bash
# sync-claude-settings.sh
#
# Read-only diff helper. Compares the live ~/.claude/settings.json against the
# tracked claude/settings.json in this repo and shows what would be stripped if
# the live file were committed verbatim.
#
# Sanitization rules (must stay in sync with claude/settings.json):
#   STRIP any permissions.allow entry containing an absolute project path
#   (e.g. /Users/<name>/workspace/<repo>/...). Those belong in
#   ~/.claude/settings.local.json (gitignored, machine-local).
#
# This script never writes anything. It only reports.

set -euo pipefail

LIVE="$HOME/.claude/settings.json"
DOTFILES_DIR="${DOTFILES_DIR:-$(cd -- "$(dirname -- "$0")/.." && pwd)}"
TRACKED="${DOTFILES_DIR}/claude/settings.json"

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is required" >&2
  exit 1
fi

if [ ! -f "$LIVE" ]; then
  echo "Live settings not found at $LIVE — nothing to compare." >&2
  exit 0
fi

if [ ! -f "$TRACKED" ]; then
  echo "Tracked settings not found at $TRACKED" >&2
  exit 1
fi

# Match anything that looks like a personal absolute project path.
PATH_PATTERN='/Users/[^"]+/workspace/'

echo "==> Permissions in live that would be STRIPPED before tracking:"
jq -r --arg p "$PATH_PATTERN" '
  .permissions.allow // []
  | map(select(test($p)))
  | .[] // empty
' "$LIVE" | sed 's/^/    - /' || true

echo
echo "==> Permissions in live that would be KEPT (generic):"
jq -r --arg p "$PATH_PATTERN" '
  .permissions.allow // []
  | map(select(test($p) | not))
  | .[] // empty
' "$LIVE" | sed 's/^/    + /'

echo
echo "==> Diff (tracked vs live, ignoring permissions.allow ordering):"
diff -u \
  <(jq -S 'del(.permissions.allow)' "$TRACKED") \
  <(jq -S 'del(.permissions.allow)' "$LIVE") \
  || true

echo
echo "Note: per-project paths belong in ~/.claude/settings.local.json (gitignored)."
