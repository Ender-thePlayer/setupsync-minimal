#!/usr/bin/env bash
set -e
drive="$(cd "$URL" && cd .. && pwd)"
rsync -avu --inplace --delete "Documents/Card/" "$drive"/Card;

current_date_time=$(date +"%d.%m.%Y")
sed -i.bak "/^[[:space:]]*|*[[:space:]]*CARD:/ s/:.*/: $current_date_time/" "$drive"/info.txt
