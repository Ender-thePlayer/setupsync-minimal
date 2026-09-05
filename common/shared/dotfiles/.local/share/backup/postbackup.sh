#!/usr/bin/env bash
set -e
drive="$(cd "$URL" && cd .. && pwd)"

current=$(date +"%d.%m.%Y")
sed -i.bak "/^[[:space:]]*|*[[:space:]]*DESKTOP:/ s/:.*/: $current/" "$drive"/info.txt