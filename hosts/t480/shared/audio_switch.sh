#!/bin/bash

export XDG_RUNTIME_DIR=/run/user/1000

USER_NAME=$(logname)
DISPLAY_USER=$(pgrep -u $USER_NAME -n gnome-session || pgrep -u $USER_NAME -n plasmashell || pgrep -u $USER_NAME -n sway || echo $USER_NAME)

# Delay to let HDMI sink register
sleep 2

# Detect if HDMI is connected
HDMI_CONNECTED=$(xrandr | grep " connected" | grep "HDMI")

if [[ -n "$HDMI_CONNECTED" ]]; then
    # HDMI is connected
    su -c "pactl set-card-profile 0 output:hdmi-stereo" $DISPLAY_USER
else
    # HDMI is disconnected
    su -c "pactl set-card-profile 0 output:analog-stereo+input:analog-stereo" $DISPLAY_USER
fi

