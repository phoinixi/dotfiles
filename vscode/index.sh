#!/bin/bash
source utils/utils.sh

cp -r .vscode ~/.vscode
cp settings.json  ~/Library/Application\ Support/Code/User/
cp keybindings.json  ~/Library/Application\ Support/Code/User/
e_success "VSCODE settings copied"

e_header "Installing extensions please wait..."
code --install-extension Equinusocio.vsc-material-theme
code --install-extension FallenMax.mithril-emmet
code --install-extension christian-kohler.npm-intellisense
code --install-extension dbaeumer.vscode-eslint
code --install-extension donjayamanne.githistory
code --install-extension eg2.tslint
e_success "Extensions for VSC have been installed. Please restart your VSC."
