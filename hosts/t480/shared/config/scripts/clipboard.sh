
while true; do
    result=$(
        rofi -dmenu \
            -kb-custom-1 "Ctrl-Delete" \
            -kb-custom-2 "Alt-Delete" \
            -display-columns 2 \
            < <(cliphist list)
    )

    case "$?" in
        1)
            exit
            ;;
        0)
            case "$result" in
                "")
                    continue
                    ;;
                *)
                    cliphist decode <<<"$result" | wl-copy
                    exit
                    ;;
            esac
            ;;
        10)
            cliphist delete <<<"$result"
            ;;
        11)
            cliphist wipe
            ;;
    esac
done
