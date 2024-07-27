#!/usr/bin/env bash


### FILE RESTORE
# It restores the user files excluding dotfiles from
# an external drive

# shellcheck source=/dev/null
source ./scaffold/functions.sh
export BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK=yes

drive_x="$( drive )"
newarchive="$( echo "y" | borg list "$drive_x/Desktop" --last 1 | awk '{print $1}' )"
current=$( pwd )

cd "$HOME" || return
echo "y" | borg extract --strip-components 2 "$drive_x"/Desktop::"$newarchive"
cd "$current" || return
rsync -avu --inplace "$drive_x/Card/" "$HOME"/Documents/Card