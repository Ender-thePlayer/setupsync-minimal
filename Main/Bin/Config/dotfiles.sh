#!/usr/bin/env bash

# shellcheck source=/dev/null
source functions.sh

glib-compile-schemas "$HOME"/.local/share/gnome-shell/extensions/AlphabeticalAppGrid@stuarthayhurst/schemas/
glib-compile-schemas "$HOME"/.local/share/gnome-shell/extensions/blur-my-shell@aunetx/schemas/



### FIREFOX
# Copies the firefox configs
profile_dir=$(find ~/.mozilla/firefox/ -maxdepth 1 -type d -name '*.default-release' -print -quit)

if [ ! "$profile_dir" ]; then
    firefox & sleep 2 && pkill firefox
    profile_dir=$(find ~/.mozilla/firefox/ -maxdepth 1 -type d -name '*.default-release' -print -quit)
fi

if [ "$profile_dir" ]; then
    rm -rf "${profile_dir:?}"
    mkdir "${profile_dir:?}"
    cp -r ./Main/Share/Config/mozilla/* "$profile_dir"
else
    warning "Default Firefox profile directory not found. Skipping..."
fi



### SKLAUNCHER
# Copies a desktop entry for sklauncher on any supported distro except arch
mkdir "$HOME"/.local/share/applications/icons/

if ! [ "$( distro )" = "arch" ]; then
    cp ./Main/Share/Config/customapps/applications/meinkraft.desktop "$HOME"/.local/share/applications/
    cp ./Main/Share/Config/customapps/applications/icons/meinkraft.png "$HOME"/.local/share/applications/icons/
fi


### CUSTOM APPS
# Copies the desktop entry for every custom app that I made
cp ./Main/Share/Config/customapps/applications/arrpc.desktop "$HOME"/.local/share/applications/
cp ./Main/Share/Config/customapps/applications/romode.desktop "$HOME"/.local/share/applications/
cp ./Main/Share/Config/customapps/applications/icons/romode.png "$HOME"/.local/share/applications/icons/



### DOTFILES
# Copies the rest of the dotfiles
shopt -s dotglob
cp -r ./Main/Share/Config/dotfiles/* "$HOME"/
