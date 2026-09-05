#!/usr/bin/env bash
### CREATED ON: 01.08.2024
### It switches the current workspace by +1 but it can only create
### one empty workspace (if there is only one workspace (workspace 1) that has an app running
### by running this script you can create another one (workspace 2) but not 2 workspaces (workspace 3) if the second one remains empty (no app running)

# Usage: workspace_switch.sh


last_workspace_windows=$(hyprctl workspaces | awk '/workspace ID/ {workspace_id=$3} /windows:/ {windows=$2} END {print windows}')
numbers=$(hyprctl workspaces | grep -oP '\(\K[0-9]+(?=\))')
highest=$(echo "$numbers" | sort -nr | head -n 1)
current=$(hyprctl activeworkspace | grep -oP '\(\K[0-9]+(?=\))')

if [ "$last_workspace_windows" -ne 0 ] || [ "$highest" -gt "$current" ]; then
    hyprctl dispatch 'hl.dsp.focus({ workspace = "r+1" })' 
fi
