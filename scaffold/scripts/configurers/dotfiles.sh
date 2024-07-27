#!/usr/bin/env bash


### CUSTOM APPS
# Copies the desktop entry for every custom app that I made
mkdir -p "$HOME"/.local/share/applications/icons/
cp ./scaffold/customapps/romode.desktop "$HOME"/.local/share/applications/
cp ./scaffold/customapps/icons/romode.png "$HOME"/.local/share/applications/icons/



### DOTFILES
# Copies the rest of the dotfiles
shopt -s dotglob
cp -r ./scaffold/dotfiles/* "$HOME"/