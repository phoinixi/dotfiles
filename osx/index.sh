#!/bin/bash
# macOS defaults. All commands write to per-user preference plists — no sudo needed.
# Re-running is safe and idempotent.

set -eu

# --- System / keyboard ---

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable smart dashes (--  →  —) — breaks code and commit messages
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable smart quotes (" → " ") — breaks code paste
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable double-space → period
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Holding a key repeats it — disables the accent picker (vim/code muscle memory)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Faster key repeat (lower = faster). Defaults: KeyRepeat=6, InitialKeyRepeat=25
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Default save panel to local disk, not iCloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# --- Screenshots ---

# Save screenshots to the Desktop in PNG format
defaults write com.apple.screencapture location -string "$HOME/Desktop"
defaults write com.apple.screencapture type -string "png"

# No drop shadow on window screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# --- Finder ---

defaults write com.apple.finder AppleShowAllFiles YES
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Don't warn on extension change
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# List view in all Finder windows (others: icnv, clmv, Flwv)
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Don't warn before emptying Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Show ~/Library
chflags nohidden ~/Library

# No .DS_Store on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# --- Dock ---

defaults write com.apple.dock tilesize -int 50

# Dark Mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Don't animate opening apps
defaults write com.apple.dock launchanim -bool false

# Show indicator lights for open apps
defaults write com.apple.dock show-process-indicators -bool true

# Suck animation for minimize
defaults write com.apple.dock mineffect suck

# No bouncing icons
defaults write com.apple.dock no-bouncing -bool true

# --- Apply ---

echo "Applying Finder & Dock changes..."
killall Finder >/dev/null 2>&1 || true
killall Dock >/dev/null 2>&1 || true

echo "macOS settings applied. Some changes may require a logout/restart."
