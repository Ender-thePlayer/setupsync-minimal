#!/usr/bin/env bash
### CREATED ON: 27.04.2025
### It preloads firefox in the background by running firefox
### and sending it to the special workspace to make subsequent processes start faster

# Usage: "preload_firefox.sh"


PROCESS_NAME="librewolf"

if pgrep -f "flatpak run.*$PROCESS_NAME" > /dev/null; then
	echo "Librewolf is already running"
	exit 1
fi

hyprctl dispatch 'hl.dsp.exec_cmd("flatpak run io.gitlab.librewolf-community")'


if ! pgrep -f "flatpak run.*$PROCESS_NAME" > /dev/null; then
	echo "Failed to start Librewolf"
	exit 1
fi

for _ in {1..100}; do
	addr=$(hyprctl clients -j | jq -r '.[] | select(.class == "librewolf" or .class == "io.gitlab.librewolf-community" or .initialClass == "librewolf" or .initialClass == "io.gitlab.librewolf-community") | .address')
	if [[ -n "$addr" && "$addr" != "null" ]]; then
		break
	fi
	sleep 0.1
done

if [[ -n "$addr" && "$addr" != "null" ]]; then
	hyprctl dispatch "hl.dsp.window.move({ workspace = 'special:magic', window='address:$addr' })"
	sleep 0.5
	hyprctl dispatch 'hl.dsp.workspace.toggle_special("magic")'
else
	echo "Window not found"
	exit 1
fi
