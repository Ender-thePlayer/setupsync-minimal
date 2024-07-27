#!/usr/bin/env bash

### LIBREWOLF
# Copies the librewolf configs
profile_dir=$(find ~/.librewolf/ -maxdepth 1 -type d -name '*.default-default' -print -quit || echo "")

if [ ! "$profile_dir" ]; then
    librewolf & sleep 2 && pkill librewolf
    profile_dir=$(find ~/.librewolf/ -maxdepth 1 -type d -name '*.default-default' -print -quit)
fi

if [ "$profile_dir" ]; then
    rm -rf "${profile_dir:?}"
    mkdir "${profile_dir:?}"
    cp -r ./scaffold/librewolf/* "$profile_dir"
else
    warning "Not moving librewolf dotfiles! Skipping... \n    >>> Default Librewolf profile directory not found. "
fi



### CUSTOM APPS
# Copies the desktop entry for every custom app that I made
mkdir -p "$HOME"/.local/share/applications/icons/
cp ./scaffold/customapps/romode.desktop "$HOME"/.local/share/applications/
cp ./scaffold/customapps/icons/romode.png "$HOME"/.local/share/applications/icons/



### DOTFILES
# Copies the rest of the dotfiles
shopt -s dotglob
cp -r ./scaffold/dotfiles/* "$HOME"/