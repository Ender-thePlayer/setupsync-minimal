#!/usr/bin/env bash
set -e
drive="$(cd "$URL" && cd .. && pwd)"
rsync -avu --inplace --delete "/run/media/eepyender/344ce62e-a0af-4bfa-935c-5676e34f7f45/Card/" "$drive"/Card;

current_date_time=$(cat /run/media/eepyender/344ce62e-a0af-4bfa-935c-5676e34f7f45/Card/date.txt || exit 1)
sed -i.bak "/^[[:space:]]*|*[[:space:]]*CARD:/ s/:.*/: $current_date_time/" "$drive"/info.txt