#!/usr/bin/env bash

DIR="$HOME/.config/polybar/scripts/rofi"
SDIR="$HOME/.config/i3/arandr"


rofi_command="rofi -no-config -theme $DIR/display-switch.rasi"

# Options
both="󰍺  Both"
monitor="󰍹  Monitor"
laptop="  Laptop"


# Variable passed to rofi
options="$both\n$monitor\n$laptop"


chosen="$(echo -e "$options" | $rofi_command -p "Search" -dmenu -selected-row 0)"
case $chosen in
    $both) "$SDIR"/both.sh ;;
    $monitor) "$SDIR"/monitor.sh ;;
    $laptop) "$SDIR"/laptop.sh ;;
esac
