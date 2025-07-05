#!/bin/bash

# TLP Performance Toggle Script
# Usage: ./tlp-toggle.sh

TLP_CONF="/etc/tlp.conf"
BACKUP_CONF="/etc/tlp.conf.backup"
HELPER_SCRIPT="/opt/tlp-toggle-helper.sh"

# Function to check current governor based on power state
get_current_governor() {
    # Check if we're on AC power or battery
    local power_source="battery"
    if [ -f "/sys/class/power_supply/ADP1/online" ]; then
        if [ "$(cat /sys/class/power_supply/ADP1/online)" = "1" ]; then
            power_source="ac"
        fi
    elif [ -f "/sys/class/power_supply/AC/online" ]; then
        if [ "$(cat /sys/class/power_supply/AC/online)" = "1" ]; then
            power_source="ac"
        fi
    elif [ -f "/sys/class/power_supply/ACAD/online" ]; then
        if [ "$(cat /sys/class/power_supply/ACAD/online)" = "1" ]; then
            power_source="ac"
        fi
    fi
    
    # Get the appropriate governor setting
    local gov=""
    if [ "$power_source" = "ac" ]; then
        gov=$(grep "^CPU_SCALING_GOVERNOR_ON_AC=" "$TLP_CONF" 2>/dev/null | cut -d'=' -f2 | tr -d '"' | tr -d "'" | xargs)
    else
        gov=$(grep "^CPU_SCALING_GOVERNOR_ON_BAT=" "$TLP_CONF" 2>/dev/null | cut -d'=' -f2 | tr -d '"' | tr -d "'" | xargs)
    fi
    
    # If empty or not found, check actual system state
    if [ -z "$gov" ] || [ "$gov" = "" ]; then
        if [ -f "/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" ]; then
            gov=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
        else
            gov="powersave"  # default fallback
        fi
    fi
    
    echo "$gov"
}

# Function to check if on battery power
is_on_battery() {
    # Check various possible AC adapter paths
    local ac_paths=(
        "/sys/class/power_supply/ADP1/online"
        "/sys/class/power_supply/AC/online" 
        "/sys/class/power_supply/ACAD/online"
        "/sys/class/power_supply/ADP0/online"
    )
    
    for ac_path in "${ac_paths[@]}"; do
        if [ -f "$ac_path" ]; then
            if [ "$(cat "$ac_path")" = "0" ]; then
                return 0  # On battery
            else
                return 1  # On AC power
            fi
        fi
    done
    
    # Fallback: assume on battery if we can't determine
    return 0
}

# Function to toggle TLP configuration
toggle_tlp() {
    # Check if we're on battery power
    if ! is_on_battery; then
        echo "🔌 AC Connected"
        notify-send "TLP Mode" "Cannot toggle - AC adapter connected. Unplug to change governor." -i dialog-warning
        return 1
    fi
    
    local current_gov=$(get_current_governor)
    
    if [ "$current_gov" = "powersave" ]; then
        # Switch to performance mode
        sudo "$HELPER_SCRIPT" performance
        echo "⚡ Performance"
        notify-send "TLP Mode" "Switched to Performance mode (Battery)" -i dialog-information
    else
        # Switch back to battery save mode
        sudo "$HELPER_SCRIPT" powersave
        echo "🔋 Battery Save"
        notify-send "TLP Mode" "Switched to Battery Save mode" -i dialog-information
    fi
}

# Function to get status for waybar
get_status() {
    if ! is_on_battery; then
        # On AC power - show different icon and disable toggle functionality
        echo '{"text": "◊", "tooltip": "TLP: AC Connected - Governor control disabled", "class": "ac-connected"}'
        return
    fi
    
    # On battery - show current governor status
    local current_gov=$(get_current_governor)
    if [ "$current_gov" = "powersave" ]; then
        echo '{"text": "○", "tooltip": "TLP: Battery Save Mode (Click to enable Performance)", "class": "battery"}'
    else
        echo '{"text": "●", "tooltip": "TLP: Performance Mode (Click to save battery)", "class": "performance"}'
    fi
}

# Main logic
case "$1" in
    "toggle")
        toggle_tlp
        ;;
    "status")
        get_status
        ;;
    *)
        echo "Usage: $0 {toggle|status}"
        exit 1
        ;;
esac
