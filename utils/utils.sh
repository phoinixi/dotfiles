#!/bin/bash

# Fonts
bold=$(tput bold)
underline=$(tput sgr 0 1)
reset=$(tput sgr0)

# Colors
purple=$(tput setaf 171)
red=$(tput setaf 1)
green=$(tput setaf 76)
tan=$(tput setaf 3)
blue=$(tput setaf 38)

#To check input is empty or not
is_empty() {
  if [ $# -eq  0 ]; then
    return 1
  fi
  return 0
}

#To check programs exit or not
is_exists() {
  if [ $(type -P $1) ]; then
    return 1
  fi
  return 0
}

#To check file exits or not
is_file_exists() {
  if [ -f "$file" ]; then
	  return 1
  fi
	return 0
}

#Custom echo functions
ask() {
  printf "\n${bold}$@${reset}"
}

thanks() {
  printf "\n${bold}${purple}$@${reset}\n"
}

header() {
  printf "\n${underline}${bold}${green}%s${reset}\n" "$@"
}

arrow() {
  printf "\n ᐅ $@\n"
}

success() {
  printf "\n${green}✔ %s${reset}\n" "$@"
}

error() {
  printf "\n${red}✖ %s${reset}\n" "$@"
}

warning() {
  printf "\n${tan}ᐅ %s${reset}\n" "$@"
}

underline() {
  printf "\n${underline}${bold}%s${reset}\n" "$@"
}

bold() {
  printf "\n${bold}%s${reset}\n" "$@"
}

note() {
  printf "\n${underline}${bold}${blue}Note:${reset} ${blue}%s${reset}\n" "$@"
}

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}
