#!/usr/bin/env bash

function welcome_message {
    echo "=================================="
    echo "Welcome to SetupSync"
    echo -e "Version:\e[1m 24.0511-beta\e[0m"
    echo "=================================="
    echo ""
    echo "Released on: 11/05/2024"
    echo ""
}
function list_message {
    echo "1) Run while installing drivers (Default)"
    echo "2) Run without installing drivers"
    echo "3) Run while ONLY installing drivers"
    echo "4) Something else..."
    echo "5) Exit"
    echo ""
}
function advanced_settings {
    echo "1) Restore only user files (e.g. Documents/)"
    echo "2) Restore only GNOME extensions"
    echo "3) Restore only DotFiles"
    echo "4) Install only apps"
    echo "5) Exit"
    echo ""
}
# function usage {
#     echo -e "Usage: You interract with the dynamic installer."
#     echo ""
# }
function drive {
    if mount | grep -q 'EU-1'; then
        mount | grep 'EU-1' | awk '{print $3}'
    elif mount | grep -q 'EU-2'; then
        mount | grep 'EU-2' | awk '{print $3}'
    else
        return 1
    fi
}
function distro {
    os_id=$(grep "^ID=" /etc/os-release | cut -d= -f2-)
    echo "$os_id"
}
# function model {
#     model_ln=$(sudo dmidecode | grep -A3 '^System Information' | awk -F ': ' '/Version/{print $2}' | awk '{print $2}')
#     echo "$model_ln"
# }
function run_message {
    echo "======================================================="
    echo -e "[RUN] $1"
    echo "======================================================="
    echo ""
}
function info_message {
    echo -e "\e[1;36m[INFO]\e[0m $1"
    echo ""
}
function fatal_error {
    echo "======================================================="
    echo -e "\e[1;6;31m[FATAL]\e[0m $1"
    echo "======================================================="
    echo ""
    echo "Error code: $2"
    exit "$2"
}
function run_successfully {
    echo "======================================================="
    echo -e "\e[1;32m[DONE]\e[0m $1"
    echo "======================================================="
}
function error_message {
    echo -e "\e[1;31m[ERROR]\e[0m $1"
    echo ""
    exit 1
}
function warning {
    echo -e "\e[1;33m[WARNING]\e[0m $1"
    echo ""
}
function refresh_sudo {
    while true; do
        sudo -v
        sleep 240
    done
}
