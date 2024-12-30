#!/usr/bin/env bash

# Ensure ~/Videos/Screencasts directory exists
mkdir -p ~/Videos/Screencasts

# If wl-screenrec is already running, stop recording.
if pgrep -x "wl-screenrec" > /dev/null; then
    killall -s 2 wl-screenrec
    exit 0
fi

# First, check for the specific Razer source
source=$(pactl list short sources | grep -oE 'alsa_output\.usb-Razer_Razer_Raiju_PM1714C01502000-00\.analog-stereo\.monitor' | head -n 1)

# If not found, look for any other bluez_output pattern
if [ -z "$source" ]; then
    source=$(pactl list short sources | grep -oE 'bluez_output\.[^ ]+\.monitor' | head -n 1)
fi

# If still not found, look for any other alsa_output pattern
if [ -z "$source" ]; then
    source=$(pactl list short sources | grep -oE 'alsa_output\.[^ ]+\.monitor' | head -n 1)
fi

# Print the result
if [ -n "$source" ]; then
    argv="--audio --audio-device $source"
else
    argv=""
fi

FILE="$HOME/Videos/Screencasts/$(date +'screencast_%Y%m%d%H%M%S.mp4')"
dunstify "Starting screencast" --timeout=1000
wl-screenrec $argv -g "$(slurp)" --filename $FILE &&
ffmpeg -i $FILE -ss 00:00:00 -vframes 1 /tmp/screenrec_thumbnail.png -y &&
printf -v out "`dunstify "Recording saved to $FILE" \
    --icon "/tmp/screenrec_thumbnail.png" \
    --action="default,Open"`" &&

# If the notification is clicked, reveal the recording in default file explorer.
case "$out" in
"default")
    gdbus call --session \
        --dest org.freedesktop.FileManager1 \
        --object-path /org/freedesktop/FileManager1 \
        --method org.freedesktop.FileManager1.ShowItems "['file://$FILE']" ""
    ;;
esac

