# Add Homebrew bin directories
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

# Set preferred editor
export EDITOR='zed'
export VISUAL='zed'

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git
  node
  npm
)
source "$ZSH/oh-my-zsh.sh"

# FNM (Fast Node Manager)
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# zoxide (smarter cd, replaces OMZ z plugin)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# atuin (shell history; keep up-arrow as default zsh history)
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

# Keychain secret fetcher. Usage: $(kc OPENAI_API_KEY)
kc() { security find-generic-password -a "$USER" -s "$1" -w 2>/dev/null; }

# Source custom aliases file if it exists
if [ -f "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# Add custom aliases/functions below
alias ls='eza --icons'
alias ll='eza -l --icons'
alias la='eza -la --icons'
alias cat='bat'

# --- Aliases Merged from oh-my-zsh/.aliases ---
#   NAVIGATION
alias w="cd ~/workspace"

# DELETE
alias rm="=rm -rf"
alias clean="find . -name '*.DS_Store' -type f -ls -delete"

# IP Address
alias ip="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# ZIP folder without hidden files
alias zip="zip -r -X -9"

# To update brew, npm, their installed packages
alias brew_update='brew update; brew upgrade; brew cleanup; npm update npm -g; npm update -g;'

## END
export PATH="$HOME/.local/bin:$PATH"
