#!/bin/sh
xrandr --output eDP --off --output HDMI-A-0 --off --output DisplayPort-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal

i3-msg restart
