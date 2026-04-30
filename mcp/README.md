# MCP (Model Context Protocol)

MCP servers extend coding agents (Claude Code, Zed) with tools beyond the built-in shell + filesystem set. Examples: GitHub API, Linear, Postgres, custom team tools.

## Where MCP servers live

| Tool          | File                               | Tracked here?          |
| ------------- | ---------------------------------- | ---------------------- |
| Claude Code   | per-project `.mcp.json`            | per-project, not here  |
| Claude Code   | `~/.claude.json` (user-scope)      | not tracked (machine)  |
| Zed           | `~/.config/zed/settings.json`      | yes (`zed/settings.json`) under `agent.mcp_servers` |
| Per-project   | `.mcp.json` at repo root           | yes, in `template/project/.mcp.json` |

## Adding a server

1. **Project-scoped (preferred):** add to the project's `.mcp.json`. Keeps the agent's capability surface scoped to one repo.
2. **User-scoped (Zed):** edit `zed/settings.json` in this dotfiles repo, under `agent.mcp_servers`.
3. **Secrets:** never inline API keys. Reference Keychain via the `kc` shell helper (see `claude/CLAUDE.md`) or a launcher script that resolves the key at start.

## Templates

- `zed.json.template` — copy/paste snippet for adding an MCP server to Zed settings.
