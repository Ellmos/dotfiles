#!/bin/sh
xrandr --output DisplayPort-0 --primary

numlockx on
feh --bg-fill ~/.config/i3/img/bg.png

xinput set-prop "pointer:Logitech G305" "Coordinate Transformation Matrix" 1, 0, 0, 0, 1, 0, 0, 0, 3.5
xinput set-prop "pointer:DELL0A78:00 04F3:3147 Touchpad" "Coordinate Transformation Matrix" 1, 0, 0, 0, 1, 0, 0, 0, 1.3
xinput set-prop "pointer:DELL0A78:00 04F3:3147 Touchpad" "Synaptics Scrolling Distance" -85 -85
xinput set-prop "pointer:DELL0A78:00 04F3:3147 Touchpad" "Synaptics Tap Action" 1 1 1 1 1 1 1
xinput set-prop "pointer:DELL0A78:00 04F3:3147 Touchpad" "Synaptics Two-Finger Scrolling" 1 1
xinput set-prop "pointer:DELL0A78:00 04F3:3147 Touchpad" "Synaptics Tap Action" 2 3 1 1 1 3 0
xinput set-prop "pointer:DELL0A78:00 04F3:3147 Touchpad" "Synaptics Click Action" 1 0 0

libinput-gestures-setup autostart start
