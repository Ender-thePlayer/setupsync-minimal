#!/usr/bin/env bash

### FILE RESTORE
# It restores the user files excluding dotfiles from
# an external drive

# shellcheck source=/dev/null
source ./scaffold/functions.sh

drive_x="$( drive )"

if ! [ "$drive_x" = "no_drive_found" ];
then
    export BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK=yes
    newarchive="$( echo "y" | borg list "$drive_x/Desktop" --last 1 | awk '{print $1}' )"
    current=$( pwd )
    cd "$HOME" || return
    echo "y" | borg extract --strip-components 2 "$drive_x"/Desktop::"$newarchive"
    cd "$current" || return
    rsync -avu --inplace "$drive_x/Card/" "$HOME"/Documents/Card
else
    warning "No drive was found! Skipping.."
fi