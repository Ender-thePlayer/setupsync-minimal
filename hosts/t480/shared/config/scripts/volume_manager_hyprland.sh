#!/bin/bash
ACTION="$1"
LOCKFILE="/tmp/volume_${ACTION}.lock"

exec 200>"$LOCKFILE"
if ! flock -n 200; then
    exit 0
fi

sleep 0.05
adjust_volume() {
    if [ "$1" == "up" ]; then
        wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ "$2"+
        message="Volume raised to"
    else
        wpctl set-volume @DEFAULT_AUDIO_SINK@ "$2"-
        message="Volume lowered to"
    fi

    volume=$(pamixer --get-volume)
    notify-send -e -h int:value:"$volume" \
        -h string:x-canonical-private-synchronous:volume_notif \
        -u low "Volume" "$message $volume%"
}
case "$ACTION" in
    "mute")
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
    "down")
        adjust_volume "down" "5%"
        ;;
    "up")
        adjust_volume "up" "5%"
        ;;
    "mic-mute")
        pamixer --default-source -t
        ;;
    *)
        echo "Usage: $0 {mute|down|up|mic-mute}"
        exit 1
        ;;
esac

exit 0
