#!/usr/bin/env zsh
# Install Node.js LTS via fnm.

if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell zsh)"
  fnm install --lts
  fnm default lts-latest
  fnm use default
  e_success "Node.js LTS installed via fnm"
else
  e_warning "fnm not found — skipping Node install. Check Brewfile."
fi

if ! command -v claude >/dev/null 2>&1 && command -v npm >/dev/null 2>&1; then
  e_arrow "Installing Claude Code CLI globally..."
  npm install -g @anthropic-ai/claude-code || e_warning "claude-code install failed; install manually"
fi

# Symlink ~/.local/bin/scaffold-ai for project bootstrap.
mkdir -p "$HOME/.local/bin"
ln -sf "${DOTFILES_DIR}/bin/scaffold-ai" "$HOME/.local/bin/scaffold-ai"
e_success "scaffold-ai linked into ~/.local/bin"
