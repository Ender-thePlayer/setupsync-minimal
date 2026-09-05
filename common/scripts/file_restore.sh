#!/usr/bin/env bash
# shellcheck source=/dev/null
source ./scaffold/functions.sh


### FILE RESTORE
# It restores the user files excluding dotfiles from
# an external drive
drive_x="$( drive )"

if ! [ "$drive_x" = "no_drive_found" ];
then
    export BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK=yes
    pc_archive="$( echo "y" | borg list "$drive_x/Desktop" --last 1 | awk '{print $1}' )"
    
    current=$( pwd )
    if ! [ "$1" = true ];
    then
        cd "$HOME" || return
        echo "y" | borg extract --strip-components 2 "$drive_x"/Desktop::"$pc_archive"
        cd "$current" || return
    else
        mkdir -p ./tmp
        mkdir -p "$HOME"/Documents/
        borg mount --numeric-ids -o noatime "$drive_x"/Desktop::"$pc_archive" ./tmp
        cp -r ./tmp/home/eepyender/Documents/Projects "$HOME"/Documents/
        cp -r ./tmp/home/eepyender/Music "$HOME"/
        cp -r ./tmp/home/eepyender/Videos "$HOME"/
        borg umount ./tmp
        rm -r ./tmp

        laptop_archive="$( echo "y" | borg list "$drive_x/Laptop" --last 1 | awk '{print $1}' )"
        cd "$HOME" || return
        echo "y" | borg extract --strip-components 2 "$drive_x"/Laptop::"$laptop_archive"
        cd "$current" || return
    fi
else
    warning "No drive was found! Skipping.."
fi