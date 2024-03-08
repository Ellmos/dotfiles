#!/bin/sh
xrandr --output DisplayPort-0 --primary

numlockx on
feh --no-fehbg --bg-fill ~/.config/i3/img/bg/akihabara_night.jpg

# xinput set-prop "pointer:Logitech G305" "libinput Accel Speed" -0.8
# xinput set-prop "pointer:DELL0A78:00 04F3:3147 Touchpad" "Coordinate Transformation Matrix" 1, 0, 0, 0, 1, 0, 0, 0, 1.3
# xinput set-prop "pointer:DELL0A78:00 04F3:3147 Touchpad" "Synaptics Scrolling Distance" -85 -85
# xinput set-prop "pointer:DELL0A78:00 04F3:3147 Touchpad" "Synaptics Tap Action" 1 1 1 1 1 1 1
# xinput set-prop "pointer:DELL0A78:00 04F3:3147 Touchpad" "Synaptics Two-Finger Scrolling" 1 1
# xinput set-prop "pointer:DELL0A78:00 04F3:3147 Touchpad" "Synaptics Tap Action" 2 3 1 1 1 3 0
# xinput set-prop "pointer:DELL0A78:00 04F3:3147 Touchpad" "Synaptics Click Action" 1 0 0

xinput set-prop "DELL0A78:00 04F3:3147 Touchpad" "libinput Tapping Enabled" 1
xinput set-prop "DELL0A78:00 04F3:3147 Touchpad" "libinput Natural Scrolling Enabled" 1

xset r rate 250

libinput-gestures-setup autostart start

picom &


warningDisplayed=false

while true
do
    battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
    if [ $battery_level -le 15 ]; then
        if ! $warningDisplayed; then
            notify-send --urgency=CRITICAL "Battery Low" "Level: $battery_level%"
            warningDisplayed=true
        fi
    else
        warningDisplayed=false
    fi
    sleep 60
done
