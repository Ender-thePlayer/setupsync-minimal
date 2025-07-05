#!/usr/bin/env bash

PROCESS_NAME="librewolf"

if pgrep -f "flatpak run.*$PROCESS_NAME" > /dev/null; then
  echo "LibreWolf is already running"
  exit 1
fi

hyprctl dispatch exec "flatpak run io.gitlab.librewolf-community"

if ! pgrep -f "flatpak run.*$PROCESS_NAME" > /dev/null; then
  echo "Failed to start LibreWolf"
  exit 1
fi

for _ in {1..100}; do
  addr=$(hyprctl clients -j | jq -r '.[] | select(.class == "librewolf" or .class == "LibreWolf" or .class == "firefox" or .initialClass == "librewolf" or .initialClass == "LibreWolf") | .address')
  if [[ -n "$addr" && "$addr" != "null" ]]; then
    break
  fi
  sleep 0.1
done

if [[ -n "$addr" && "$addr" != "null" ]]; then
  hyprctl dispatch movetoworkspace "special:magic,address:$addr"
  sleep 0.5
  hyprctl dispatch togglespecialworkspace magic
else
  echo "Window not found"
  exit 1
fi
