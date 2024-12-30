#!/usr/bin/env bash
set -e
drive="$(cd "$URL" && cd .. && pwd)"

current_date_time=$(cat Documents/Card/date.txt || exit 1)
sed -i.bak "/^[[:space:]]*|*[[:space:]]*CARD:/ s/:.*/: $current_date_time/" "$drive"/info.txt

current=$(date +"%d.%m.%Y")
sed -i.bak "/^[[:space:]]*|*[[:space:]]*DESKTOP:/ s/:.*/: $current/" "$drive"/info.txt

