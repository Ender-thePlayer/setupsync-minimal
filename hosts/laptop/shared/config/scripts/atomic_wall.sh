#!/usr/bin/env bash
### CREATED ON: 26.07.2026
### It switches the current wallpaper from whatever it is
### to something safe to show in class for example

# Usage: "atomic_wall.sh" to restore
#	 "atomic_wall.sh nuke" to change the wallpaper to the safe one


set -x
nuke=false

case "$1" in
    "nuke")
        nuke=true
        ;;
esac

if test -d "$HOME/.config/walls/active" || ls "$HOME/.config/walls/active/current_wallpaper."* >/dev/null 2>&1; then
	if $nuke; then
	     awww img "$HOME/.config/walls/atomic."* --filter Nearest
	else
	     awww img "$HOME/.config/walls/active/current_wallpaper."* --filter Nearest
	fi
fi
