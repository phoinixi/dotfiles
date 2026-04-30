# macOS dev environment for human + AI coding agents

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Personal dotfiles, designed around one premise: developer workflows now run on **two co-equal runtimes** — the human shell and the agent harness. This repo provisions both on a fresh macOS machine in a single `./install.sh`.

## What gets provisioned

**Human shell**

- zsh + Oh My Zsh, `eza`, `bat`, `ripgrep`, `fzf`, `git-delta`, `zoxide`, `atuin`, `gh`, `httpie`, `jq`/`yq`.
- Ghostty as the terminal, Zed as the editor. VS Code kept as a backup.
- Node.js via `fnm`, package managers `pnpm` + `npm`.
- Sensible Git config and a comprehensive global gitignore.
- macOS defaults (Finder / Dock / keyboard) applied via `osx/index.sh`.

**Agent harness**

- `~/.claude/` symlinked to this repo:
  - `settings.json` (sanitized — see [Sanitization](#sanitization))
  - `CLAUDE.md` (global agent memory)
  - `agents/`, `commands/`, `hooks/`, `output-styles/` for authored cognitive tools
  - `plugins/installed_plugins.json` declaring enabled plugins (`caveman`, `vercel`, `coderabbit`)
- Zed agent configured under `zed/settings.json`.
- MCP server templates in `mcp/`.
- `bin/scaffold-ai` to drop a `.claude/` + `AGENTS.md` + `.mcp.json` starter into any new repo.

## Install

```bash
git clone https://github.com/phoinixi/dotfiles.git ~/workspace/dotfiles
cd ~/workspace/dotfiles
./install.sh
```

Run a single module instead of everything:

```bash
./install.sh --list              # see available modules
./install.sh --only claude       # re-symlink the Claude harness only
./install.sh --only zed
./install.sh --only ghostty
```

After install, restart your terminal (or `source ~/.zshrc`).

## Sanitization

`~/.claude/settings.json` mixes durable user preferences with per-project absolute paths in `permissions.allow`. Only the durable parts are tracked.

- **Tracked here** (`claude/settings.json`): `enabledPlugins`, `effortLevel`, `editorMode`, generic permission patterns (`Bash(git push:*)`, `Bash(rg:*)`, `Bash(gh api *)`, etc.).
- **Machine-local** (`~/.claude/settings.local.json`, gitignored): per-project allowlists like `Bash(node /Users/.../some-project/scripts/x.js)`. The install script never overwrites this file.

Before committing changes pulled from the live settings, run:

```bash
./scripts/sync-claude-settings.sh
```

It diffs live vs tracked and prints exactly which entries would be stripped.

## Secrets

Stored in macOS Keychain. The `.zshrc` exposes a tiny helper:

```sh
kc OPENAI_API_KEY      # prints the secret to stdout
$(kc GITHUB_TOKEN)     # use inline as a value
```

To add a secret:

```bash
security add-generic-password -a "$USER" -s OPENAI_API_KEY -w
```

Swap to a different vault later (Bitwarden, doppler, …) without touching the rest of the repo.

## Per-project scaffolding

`scaffold-ai` drops the AI-aware starter into any directory:

```bash
mkdir my-app && cd my-app
scaffold-ai .                      # uses dirname as project name
scaffold-ai . --name my-app        # explicit name
```

It writes `.claude/settings.json`, `.claude/commands/`, `.mcp.json`, `AGENTS.md`, `.editorconfig`, `.gitignore`, replacing `{{PROJECT}}` with the chosen name.

## Layout

```
.zshrc                  shell config
Brewfile                brew bundle source
install.sh              dispatcher (--only <module> for partial runs)
install/                numbered modules (00-brew … 60-macos)
scripts/                one-off helpers
utils/                  install printers
git/                    gitconfig + global gitignore
osx/                    macOS defaults
claude/                 Claude Code harness (settings, CLAUDE.md, agents, commands, hooks, output-styles, plugins)
zed/                    Zed editor config
ghostty/                Ghostty terminal config
raycast/                extensions manifest (real Raycast sync = Cloud Sync in app)
mcp/                    MCP server templates and notes
template/project/       starter dropped into new repos by scaffold-ai
bin/scaffold-ai         project bootstrap CLI
AGENTS.md               contract for agents modifying this repo
```

## Customization

- Add a CLI? Edit `Brewfile`, re-run `./install.sh --only brew`.
- Add a Claude slash command? Drop a `.md` into `claude/commands/`. No install re-run needed (the parent dir is symlinked).
- Add a new install step? See [`AGENTS.md`](AGENTS.md) — create `install/<NN>-<name>.sh` and append the suffix to the `MODULES` array in `install.sh`.

## Issues

[Open an issue](https://github.com/phoinixi/dotfiles/issues/new).
