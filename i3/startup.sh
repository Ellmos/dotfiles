#!/bin/sh
xinput set-prop "pointer:Logitech G305" "Coordinate Transformation Matrix" 1, 0, 0, 0, 1, 0, 0, 0, 1.9
xrandr --output DisplayPort-0 --primary
xinput set-prop 11 329 -85 -85
xinput set-prop 12 331 -85 -85
