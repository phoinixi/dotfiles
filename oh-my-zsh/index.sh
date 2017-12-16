#!/bin/bash
source utils/utils.sh

ZSH=~/.oh-my-zsh

if [ -d "$ZSH" ]; then
  e_warning "Oh My Zsh is already installed. skipping.."
else
  curl -L http://install.ohmyz.sh | sh
fi

#To install ZSH themes & aliases
e_header "Copying ZSH themes & aliases..."
e_note "Check .aliases file for more details."
cp oh-my-zsh/.aliases ~/.aliases
cp oh-my-zsh/.zshrc ~/.zshrc
