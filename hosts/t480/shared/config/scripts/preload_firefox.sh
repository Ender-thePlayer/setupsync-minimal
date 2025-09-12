#!/usr/bin/env bash

PROCESS_NAME="floorp"

if pgrep -f "flatpak run.*$PROCESS_NAME" > /dev/null; then
  echo "Floorp is already running"
  exit 1
fi

hyprctl dispatch exec "flatpak run one.ablaze.floorp"

if ! pgrep -f "flatpak run.*$PROCESS_NAME" > /dev/null; then
  echo "Failed to start Floorp"
  exit 1
fi

for _ in {1..100}; do
  addr=$(hyprctl clients -j | jq -r '.[] | select(.class == "floorp" or .class == "Floorp" or .initialClass == "floorp" or .initialClass == "Floorp") | .address')
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
