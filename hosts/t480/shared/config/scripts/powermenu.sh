#!/usr/bin/env bash
uptime="`uptime -p | sed -e 's/up //g'`"
host=$(cat /proc/sys/kernel/hostname)

shutdown='󰐥 Shutdown'  
reboot='󰜉 Reboot'  
lock='󰌾 Lock'      
suspend='󰤄 Suspend'    
logout='󰍃 Logout'      

rofi_cmd() {
    rofi -dmenu \
        -p "$host" \
        -mesg "Uptime: $uptime" \
        -theme "$HOME"/.config/rofi/powermenu.rasi
}

run_rofi() {
    echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

run_cmd() {
    if [[ $1 == '--shutdown' ]]; then
        systemctl poweroff
    elif [[ $1 == '--reboot' ]]; then
        systemctl reboot
    elif [[ $1 == '--suspend' ]]; then
	systemctl suspend
    elif [[ $1 == '--logout' ]]; then
        hyprctl dispatch exit
    fi
}

chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
        run_cmd --shutdown
        ;;
    $reboot)
        run_cmd --reboot
        ;;
    $lock)
   	hyprlock
        ;;
    $suspend)
        run_cmd --suspend
        ;;
    $logout)
        run_cmd --logout
        ;;
esac
