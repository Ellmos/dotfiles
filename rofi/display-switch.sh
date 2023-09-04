#!/usr/bin/env bash

DIR="$HOME/.config/rofi/themes"
SDIR="$HOME/.config/i3/scripts"


rofi_command="rofi -no-config -theme $DIR/display-switch.rasi"

# Options
both="󰍺  Both"
monitor="󰍹  Monitor"
laptop="  Laptop"


# Variable passed to rofi
options="$both\n$monitor\n$laptop"


chosen="$(echo -e "$options" | $rofi_command -p "Search" -dmenu -selected-row 0)"
case $chosen in
    $both)     "$SDIR"/display-switch.sh both;;
    $monitor)  "$SDIR"/display-switch.sh monitor;;
    $laptop)   "$SDIR"/display-switch.sh laptop;;
esac
