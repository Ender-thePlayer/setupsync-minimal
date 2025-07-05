#!/bin/bash

# TLP Toggle Helper Script - runs with root privileges
# Usage: ./tlp-toggle-helper.sh {performance|powersave}

TLP_CONF="/etc/tlp.conf"
BACKUP_CONF="/etc/tlp.conf.backup"

# Validate input
if [ "$#" -ne 1 ] || { [ "$1" != "performance" ] && [ "$1" != "powersave" ]; }; then
    echo "Usage: $0 {performance|powersave}"
    exit 1
fi

# Create backup if it doesn't exist
if [ ! -f "$BACKUP_CONF" ]; then
    cp "$TLP_CONF" "$BACKUP_CONF"
fi

# Function to set or add config line
set_config() {
    local key="$1"
    local value="$2"
    
    if grep -q "^${key}=" "$TLP_CONF"; then
        # Line exists, update it
        sed -i "s/^${key}=.*/${key}=\"${value}\"/" "$TLP_CONF"
    elif grep -q "^#${key}=" "$TLP_CONF"; then
        # Line exists but is commented, uncomment and update
        sed -i "s/^#${key}=.*/${key}=\"${value}\"/" "$TLP_CONF"
    else
        # Line doesn't exist, add it
        echo "${key}=\"${value}\"" >> "$TLP_CONF"
    fi
}

# Apply configuration based on mode
if [ "$1" = "performance" ]; then
    # Performance mode - only change battery settings
    set_config "CPU_SCALING_GOVERNOR_ON_BAT" "performance"
else
    # Battery save mode - set battery to powersave
    set_config "CPU_SCALING_GOVERNOR_ON_BAT" "powersave"
fi

# Restart TLP to apply changes
tlp start

echo "TLP configuration updated to $1 mode"
