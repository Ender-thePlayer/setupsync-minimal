#!/usr/bin/bash
### CREATED ON: 23.07.2026
### NowPlayingCTL. This script is used by Hyprlock to
### generate media controls on lock screen and by Hyprland via shortcuts
### It can play, pause, skip to the next song, backtrack to the last song,
### stop the player and show what's playing in a HTML formatted string

# Usage: "npctl.sh" to show what's playing
#	 "npctl.sh --toggle" to toggle between playing and paused
#	 "npctl.sh --prev" to backtrack to the last song
#	 "npctl.sh --next" to skip to the next song
#	 "npctl.sh --stop" to stop the player

# Priority Levels:
# 3 = Playing
# 2 = Paused
# 1 = Stopped (but has media/title)
# 0 = Ghost / No media like chromium based browsers


title_max_len=80
artist_max_len=100
players_list=$(playerctl -l 2>/dev/null)
active_player=""
active_player_priority=0

while IFS= read -r player; do
if [ -z "$player" ]; then continue; fi
status=$(playerctl -p "$player" status 2>/dev/null | tr '[:upper:]' '[:lower:]')
title=$(playerctl -p "$player" metadata title 2>/dev/null)

current_priority=0
    if [ "$status" == "playing" ]; then
        current_priority=3
    elif [ "$status" == "paused" ]; then
        current_priority=2
    elif [ -n "$title" ]; then
        current_priority=1
    else
        current_priority=0
    fi
    
if [ "$current_priority" -gt "$active_player_priority" ]; then
    active_player="$player"
    active_player_priority=$current_priority
fi

done <<< "$players_list"

case "$1" in
    --toggle)
        [[ -n "$active_player" ]] && playerctl -p "$active_player" play-pause
        exit 0
        ;;
    --stop)
        [[ -n "$active_player" ]] && playerctl -p "$active_player" stop
        exit 0
        ;;
    --next)
        [[ -n "$active_player" ]] && playerctl -p "$active_player" next
        exit 0
        ;;
    --prev)
        [[ -n "$active_player" ]] && playerctl -p "$active_player" previous
        exit 0
        ;;
esac

if [[ -z "$active_player" ]]; then
    exit 0
fi

escape_characters() {
    echo "$1" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g'
}

truncate_text() {
    local text="$1"
    local max="$2"
    if [ "${#text}" -gt "$max" ]; then
        echo "${text:0:$max}..."
    else
        echo "$text"
    fi
}

if [[ -n "$active_player" ]]; then
    raw_title=$(playerctl -p "$active_player" metadata title 2>/dev/null)
    raw_artist=$(playerctl -p "$active_player" metadata artist 2>/dev/null)
    raw_title=$(truncate_text "$raw_title" "$title_max_len")
    raw_artist=$(truncate_text "$raw_artist" "$artist_max_len")

    clean_name="${active_player%%.*}"
    clean_name="$(tr '[:lower:]' '[:upper:]' <<< ${clean_name:0:1})${clean_name:1}"
    player_display_name=$(escape_characters "$clean_name")
    song_title=$(escape_characters "$raw_title")
    song_artist=$(escape_characters "$raw_artist")
fi

status=$(playerctl -p "$active_player" status 2>/dev/null)
if [[ "$status" != "Playing" ]]; then
    player_status="(Paused)"
else
    player_status=""
fi

echo -e "<span font_weight='light' size='small' alpha='80%'>${player_display_name} ${player_status}</span>\n<b>${song_title}</b>\n<span alpha='80%' size='small' style='italic'>${song_artist}</span>"
