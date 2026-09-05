#!/usr/bin/env bash
set -e

BACKUPROOT="$HOME/.local/share/backup"
ASKPASS="$BACKUPROOT/zenity-askpass"
LOGFILE="$BACKUPROOT/log"

if [ ! -d "$BACKUPROOT" ]; then
    mkdir -p "$BACKUPROOT"
fi

rm -f "$LOGFILE"
touch "$LOGFILE"

function drive {
    if mount | grep -q 'EF95-0C0B'; then
        mount | grep 'EF95-0C0B' | awk '{print $3}'
    else
        echo "$(date): The SD Card isn't mounted. Please mount and try again!" >> "$LOGFILE"
        zenity --error --text "The SD Card isn't mounted. Please mount and try again!"
        exit 1
    fi
}

if [ ! -x "$ASKPASS" ]; then
    echo "$(date): 'zenity-askpass' wrapper script missing. Creating new one..." >> "$LOGFILE"
    cat > "$ASKPASS" << 'EOF'
#!/bin/bash
exec zenity --password --title="SSH"
EOF
    chmod +x "$ASKPASS"
    echo "$(date): 'zenity-askpass' wrapper script created!" >> "$LOGFILE"
fi

export SSH_ASKPASS_REQUIRE=force
export SSH_ASKPASS="$ASKPASS"

DEST="$(drive)"

echo "$(date): Running rsync command..." >> "$LOGFILE"

if ! setsid rsync --exclude-from="$BACKUPROOT/EXCLUDED.txt" --update --progress \
    -e 'ssh -p 2222' -azv \
    192.168.1.10:/sdcard/ \
    "$DEST/"; then
    echo "$(date): rsync command failed!" >> "$LOGFILE"
    zenity --error --text "rsync command failed!"
    exit 1
fi

echo "$(date): rsync command ran successfully!" >> "$LOGFILE"