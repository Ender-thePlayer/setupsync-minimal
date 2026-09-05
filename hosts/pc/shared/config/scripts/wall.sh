#!/usr/bin/env bash
### CREATED ON: 30.12.2024
### It tries to put the wallpaper if awww's cache gets wiped
### If no wallpaper is found it fallbacks to a preconfigured one

# Usage: "wall.sh"


set -x
if ! test -d "$HOME/.config/walls/active" || ! ls "$HOME/.config/walls/active/current_wallpaper."* >/dev/null 2>&1; then
    awww img "$HOME/.config/walls/1.png" --filter Nearest
    sed -i "s|^\(\s*path\s*=\s*\).*$|\1$HOME/.config/walls/1.png|" "$HOME/.config/hypr/hyprlock.conf"
elif [ -z "$(ls -A "$HOME/.cache/awww")" ]; then
    awww img "$HOME/.config/walls/active/current_wallpaper".* --filter Nearest
fi
