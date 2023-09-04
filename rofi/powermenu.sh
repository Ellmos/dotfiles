#!/usr/bin/env bash

DIR="~/.config/rofi/themes"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -no-config -theme $DIR/powermenu.rasi"

# Options
lock="  Lock"
suspend="  Sleep"
logout="󰗼  Logout"
shutdown="⏻  Shutdown"
reboot="  Restart"


# Variable passed to rofi
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
case $chosen in
    $lock) bash ~/.config/i3/powermenu/lock.sh ;;
    $suspend) systemctl suspend ;;
    $logout) i3-msg exit ;;
    $shutdown) systemctl poweroff ;;
    $reboot) systemctl reboot ;;
esac
