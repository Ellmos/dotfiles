#!/bin/sh

# Script to toggle resize mode
current_mode=$(hyprctl activewindow)

if [ "$current_mode" = "resize" ]; then
    hyprctl dispatch globalkeybind clear
else
    hyprctl dispatch globalkeybind load resize
fi
