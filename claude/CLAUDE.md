# Global Claude memory

This file is read by Claude Code on every session. Keep it short and durable. Per-project context belongs in each project's own `AGENTS.md` or `CLAUDE.md`, not here.

## User

- Frontend / full-stack developer on macOS.
- Primary editor: Zed. Terminal: Ghostty. Shell: zsh + Oh My Zsh.
- Node.js managed by `fnm`; package managers: `npm`.

## Working style

- Be concise. Match response length to question complexity.
- Default to editing existing files over creating new ones.
- No comments in code unless the *why* is non-obvious.
- No premature abstractions, no speculative error handling, no backward-compat shims.

## Secrets

- Stored in macOS Keychain. Helper available in `.zshrc`:
  ```sh
  kc <SECRET_NAME>     # prints secret to stdout
  ```
- Never commit secrets. Never write API keys into `.env` files tracked by git. `.env.example` is fine.
- If a secret is missing in Keychain, ask — do not invent placeholder strings.

## Tools available

- Plugins enabled globally: `caveman` (compressed comms), `vercel` (deployment/Next.js), `coderabbit` (PR review).
- MCP servers: configured per-project in `.mcp.json`. Global MCP servers, when added, live in `~/.config/zed/settings.json` under `agent.mcp_servers` or in this dotfiles repo's `mcp/` dir.

## Dotfiles repo

- This file lives at `~/.claude/CLAUDE.md` (symlinked from `~/workspace/dotfiles/claude/CLAUDE.md`).
- To edit it, edit the file in the dotfiles repo and commit there.
- See `~/workspace/dotfiles/AGENTS.md` for the contract on how to extend this dotfiles repo itself.
