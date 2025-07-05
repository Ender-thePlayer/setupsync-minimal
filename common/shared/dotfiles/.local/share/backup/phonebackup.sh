#!/usr/bin/env bash
set -e

MOUNTPOINT="$HOME/.cache/phone"
prebackup=false
postbackup=false
        
case $1 in
-pre)
    prebackup=true
    ;;
-post)
    postbackup=true
    ;;
*)
    exit 1
    ;;
esac

if $prebackup; then
	mkdir -p "$MOUNTPOINT"
	adb wait-for-device
	
	if ! mountpoint -q "$MOUNTPOINT"; then
	    adbfs "$MOUNTPOINT"
	    current_date_time=$(date +"%d.%m.%Y")
	    #echo "$current_date_time" > Documents/Card/date.txt

	    echo "$current_date_time" > tmp.txt
	    
	fi
	echo "Hehe, cine vede asta ma-sa-i ghei"
	
elif $postbackup; then
	fusermount -uz "$MOUNTPOINT"
	rm -r "$MOUNTPOINT"
fi
