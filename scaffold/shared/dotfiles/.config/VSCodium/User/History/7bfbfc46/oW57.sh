#!/usr/bin/env bash

function welcome_message {
    echo "=================================="
    echo "Welcome to SetupSync"
    echo -e "Version:\e[1m 24.1201\e[0m"
    echo "=================================="
    echo ""
    echo "Released on: 01/12/2024"
    echo ""
}
function list_message {
    echo "1) Run normally (Default)"
    echo "2) Restore only user files (e.g. Documents/)"
    echo "3) Restore only configs"
    echo "4) Install only apps"
    echo "5) Exit"
    echo ""
}
function drive {
    if mount | grep -q 'EU-1'; then
        mount | grep 'EU-1' | awk '{print $3}'
    elif mount | grep -q 'EU-2'; then
        mount | grep 'EU-2' | awk '{print $3}'
    else
        return 1
    fi
}
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
    echo "    >>> Error code: $2"
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
