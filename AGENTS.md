# AGENTS.md — contract for agents modifying this repo

This dotfiles repo provisions two co-equal runtimes on a fresh macOS machine: the **human shell** (zsh, eza, bat, ghostty) and the **agent harness** (`~/.claude/`, `~/.config/zed/`, MCP servers, scaffolding template). Both are versioned. Both ship through one `./install.sh`.

If you are an agent (Claude Code, Zed agent, etc.) modifying this repo, follow the rules below.

## Top-level layout

```
.zshrc                shell config (symlinked to ~/.zshrc)
Brewfile              brew bundle source of truth
install.sh            dispatcher; parses --only and runs install/*.sh in order
install/              numbered modules (00-brew, 10-shell, 20-git, 30-claude, 40-zed, 45-ghostty, 50-node, 55-raycast, 60-macos)
install/lib.sh        shared link_file() helper for modules
scripts/              one-off helpers (sync-claude-settings.sh, ...)
utils/utils.sh        e_header / e_arrow / e_success printers
git/                  .gitconfig + .gitignore_global
osx/                  macOS defaults (Finder/Dock/keyboard)
claude/               Claude Code harness, symlinked into ~/.claude/
  settings.json       sanitized — see "Sanitization rules" below
  CLAUDE.md           global memory for Claude Code
  agents/             reusable subagents (.md files)
  commands/           slash commands (.md files)
  hooks/              event hook scripts referenced from settings.json
  output-styles/      authored output styles
  plugins/installed_plugins.json
zed/                  Zed editor config (settings.json, keymap.json)
ghostty/              Ghostty terminal config
raycast/              extensions.txt manifest + README (no real configs to track)
mcp/                  README + templates for MCP servers
template/project/     scaffold dropped into new repos by bin/scaffold-ai
bin/                  CLIs symlinked into ~/.local/bin (scaffold-ai)
```

## Rules

1. **Add a tool? Update the Brewfile.** Every CLI or cask the install assumes must live there. Don't `brew install` outside the Brewfile.
2. **Add a Claude command/agent/hook?** Drop the `.md` (or hook script) into `claude/{commands,agents,hooks,output-styles}/`. The `30-claude.sh` module already symlinks the parent directory, so new files appear automatically.
3. **Add a new install step?** Create `install/<NN>-<name>.sh` with a numeric prefix that fits its execution order, and add the suffix to the `MODULES` array in `install.sh`. Source `install/lib.sh` for the `link_file` helper.
4. **Editing settings.json:** if you sync from the live `~/.claude/settings.json`, run `./scripts/sync-claude-settings.sh` first to see what would be stripped. Per-project absolute paths must NOT be committed — they belong in `~/.claude/settings.local.json` (machine-local, gitignored).
5. **Secrets:** never commit. Use the `kc` shell helper documented in `claude/CLAUDE.md` to read from macOS Keychain. `.env.example` files are fine; `.env` files are not.
6. **Idempotency:** every `install/*.sh` must be safe to re-run. `link_file` already backs up real files to `${path}.bak`. Don't bypass it.
7. **No editor lock-in:** when adding agent capabilities, prefer the editor-agnostic location (`claude/`) over an editor-specific one (`zed/`) when the choice exists.
8. **Comments:** apply the user's "no unnecessary comments" rule here too. The README is the docs surface.

## Sanitization rules for `claude/settings.json`

- KEEP: `enabledPlugins`, `effortLevel`, `editorMode`, `awaySummaryEnabled`, `agentPushNotifEnabled`, `skipAutoPermissionPrompt`, `preferredNotifChannel`, `permissions.defaultMode`, generic `permissions.allow` entries (e.g. `Bash(git push:*)`, `Bash(rg:*)`, `Bash(gh api *)`).
- STRIP: any `permissions.allow` entry containing an absolute path under `/Users/<name>/workspace/`. Move those to `~/.claude/settings.local.json`.

## How to verify changes

```bash
shellcheck install.sh install/*.sh scripts/*.sh
jq . claude/settings.json claude/plugins/installed_plugins.json zed/settings.json
./install.sh --list
./install.sh --only claude        # re-run a single module
./scripts/sync-claude-settings.sh # diff live vs tracked
./bin/scaffold-ai /tmp/test       # dry-run scaffolder
```
