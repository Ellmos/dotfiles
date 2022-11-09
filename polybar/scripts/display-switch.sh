#!/usr/bin/env bash

DIR="$HOME/.config/polybar/scripts"
SDIR="$HOME/.config/i3/arandr"

# Launch Rofi
MENU="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '' \
-theme $DIR/rofi/styles.rasi \
<<< " Both| Monitor| Laptop|")"
            case "$MENU" in
				*Both) "$SDIR"/both.sh ;;
				*Monitor) "$SDIR"/monitor.sh --blue ;;
				*Laptop) "$SDIR"/laptop.sh --blue-gray ;;
            esac
