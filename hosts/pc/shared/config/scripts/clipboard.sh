#!/usr/bin/env bash
### CREATED ON: 25.07.2024
### Clipboard manager that uses rofi as a frontend and
### cliphist as a backend

# Usage: "clipboard.sh" brings up rofi


while true; do
    result=$(
        rofi -dmenu \
            -kb-custom-1 "Ctrl-Delete" \
            -kb-custom-2 "Alt-Delete" \
            -display-columns 2 \
            < <(cliphist list)
    )

    rofi_exit_code=$?

    case $rofi_exit_code in
        0)
            if [[ -n "$result" ]]; then
                cliphist decode <<<"$result" | wl-copy
            fi
            exit 0
            ;;
        1)
            exit 0
            ;;
        10)
            if [[ -n "$result" ]]; then
                cliphist delete <<<"$result"
            fi
            ;;
        11)
            cliphist wipe
            ;;
    esac
done
