 # Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export LSCOLORS='exfxcxdxbxegedabagacad'
export CLICOLOR=true

ZSH_THEME="robbyrussell"
plugins=(git npm)

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
source $ZSH/oh-my-zsh.sh
# Setting zsh aliases
source $HOME/.aliases

clear
