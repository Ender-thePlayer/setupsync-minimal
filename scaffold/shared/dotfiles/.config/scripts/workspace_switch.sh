#!/usr/bin/env bash

last_workspace_windows=$(hyprctl workspaces | awk '/workspace ID/ {workspace_id=$3} /windows:/ {windows=$2} END {print windows}')

numbers=$(hyprctl workspaces | grep -oP '\(\K[0-9]+(?=\))')
highest=$(echo "$numbers" | sort -nr | head -n 1)

current=$(hyprctl activeworkspace | grep -oP '\(\K[0-9]+(?=\))')

if ( [ $last_workspace_windows -ne 0 ] || [ $highest -gt $current ] ); then
    hyprctl dispatch workspace r+1 
fi
