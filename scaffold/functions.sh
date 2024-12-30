#!/usr/bin/env bash

function welcome_message {
    echo "=================================="
    echo "Welcome to SetupSync"
    echo -e "Version:\e[1m 24.1230\e[0m"
    echo "=================================="
    echo ""
    echo "Released on: 30/12/2024"
    echo ""
}
function drive {
    if mount | grep -q 'EU-1'; then
        mount | grep 'EU-1' | awk '{print $3}'
    elif mount | grep -q 'EU-2'; then
        mount | grep 'EU-2' | awk '{print $3}'
    else
        echo "no_drive_found"
    fi
}
function info_message {
    echo -e "\n\e[1;36m[INFO]\e[0m $1"
}
function fatal_error {
    echo "======================================================="
    echo -e "\e[1;6;31m[FATAL]\e[0m $1"
    echo "======================================================="
    echo ""
    echo "    >>> Error code: $2"
    exit "$2"
}
function run_successfully {
    echo "======================================================="
    echo -e "\e[1;32m[DONE]\e[0m $1"
    echo "======================================================="
    echo ""
}
function error_message {
    echo -e "\n\e[1;31m[ERROR]\e[0m $1"
    exit 1
}
function warning {
    echo -e "\n\e[1;33m[WARNING]\e[0m $1"
    echo ""
}
function refresh_sudo {
    while true; do
        sudo -v
        sleep 120
    done
}
