#!/bin/bash

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Removed genie animation
defaults write com.apple.dock mineffect suck

# Removes bouncing animation
defaults write com.apple.dock no-bouncing -bool true

killall Dock
