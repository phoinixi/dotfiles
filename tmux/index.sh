#!/bin/bash -e

TMUX=$(which tmux)
TMUX_CONF=~/.tmux.conf
TERM_TYPE=xterm-256color

if [ -n "$TMUX" ]; then
  e_warning "Tmux is already installed. skipping.."
else
  e_header "Installing tmux..."
  brew install tmux
fi

if [ -f "$TMUX_CONF" ]; then
  e_warning "tmux.conf already exists, skipping.."
else
  e_header "Copying tmux config"
  cp tmux/tmux.conf ~/.tmux.conf
fi

function addTermType() {
  PROFILE_FILE=~/.bash_profile
  ZSH=~/.zshrc

  if [ -f "$ZSH" ]; then
    PROFILE_FILE=$ZSH
  fi

  e_header "Add terminal type in $PROFILE_FILE"
  cat <<EOT >> $PROFILE_FILE

# Set term type for tmux
export TERM=$TERM_TYPE
EOT
}

if [[ "$TERM" == "$TERM_TYPE" ]]; then
  e_header "Term type is already $TERM_TYPE"
else
  addTermType
fi

