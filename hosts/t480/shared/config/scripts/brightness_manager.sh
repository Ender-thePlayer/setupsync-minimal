#!/bin/bash

adjust_brightness() {
    if [ "$1" == "up" ]; then
        brightnessctl s "+$2"
        message="Brightness raised to"
    else
        brightnessctl s "$2-"
        message="Brightness lowered to"
    fi
    
    brightness=$(brightnessctl -m | awk -F, '{print substr($4, 0, length($4)-1)}')
    
    notify-send -e -h int:value:"$brightness" \
        -h string:x-canonical-private-synchronous:brightness_notif \
        -u low "Brightness" "$message $brightness%"
}

case "$1" in
    "down")
        adjust_brightness "down" "5%"
        ;;
    "up")
        adjust_brightness "up" "5%"
        ;;
    *)
        echo "Usage: $0 {down|up}"
        exit 1
        ;;
esac

exit 0
