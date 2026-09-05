#!/usr/bin/env bash
### CREATED ON: 13.10.2024
### This script wrappes wf-recorder, a GPU accelerated screen-recorder
### Can record the entire screen or a region without the need for xdg-desktop-portal-hyprland

# Usage: "screenrec.sh" toggles between starting a recording and saving it, at the region select part can press ESC to cancel the recording


mkdir -p ~/Videos/Screencasts

if pgrep -x "wf-recorder" > /dev/null; then
    killall -s 2 wf-recorder
    exit 0
fi

MONITOR="$(pactl get-default-sink).monitor"
FILE="$HOME/Videos/Screencasts/$(date +'screencast_%Y%m%d%H%M%S.mp4')"

notify-send "Starting screencast" --expire-time=1000

wf-recorder -g "$(slurp)" --audio="$MONITOR" -c h264_vaapi -d /dev/dri/renderD128 \
--codec-param qp=22 \
--codec-param profile=high \
--codec-param colorspace=bt709 \
--codec-param color_range=limited \
--file="$FILE" &&

ffmpeg -i "$FILE" -ss 00:00:00 -vframes 1 -update 1 /tmp/screenrec_thumbnail.png -y &&

out=$(notify-send "Recording saved to $FILE" \
    --icon "/tmp/screenrec_thumbnail.png" \
    --action=open="Open")
    
case "$out" in
"open")
    xdg-open "$FILE"
    ;;
esac
