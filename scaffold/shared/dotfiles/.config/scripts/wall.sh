#!/bin/bash
if ! test -d "$HOME/.config/walls/active" || ! ls "$HOME/.config/walls/active/current_wallpaper."* >/dev/null 2>&1; then
    swww img "$HOME/.config/walls/1.png" --filter Nearest
    sed -i "s|^\(\s*path\s*=\s*\).*$|\1$HOME/.config/walls/1.png|" "$HOME/.config/hypr/hyprlock.conf"
fi

