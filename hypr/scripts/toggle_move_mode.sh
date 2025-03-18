#!/bin/sh

# Script to toggle move mode
current_mode=$(hyprctl activewindow)

if [ "$current_mode" = "move" ]; then
    hyprctl dispatch globalkeybind clear
else
    hyprctl dispatch globalkeybind load move
fi
