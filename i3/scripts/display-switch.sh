#! /usr/bin/env bash

if [[ $1 == "laptop" ]]; then
    xrandr --output eDP --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-A-0 --off --output DisplayPort-0 --off
elif [[ $1 == "monitor" ]]; then
    xrandr --output eDP --off --output HDMI-A-0 --off --output DisplayPort-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal
elif [[ $1 == "both" ]]; then
    xrandr --output eDP --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-A-0 --off --output DisplayPort-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal
fi;


i3-msg restart
