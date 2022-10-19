#!/bin/sh
xrandr --output DisplayPort-0 --primary

xinput set-prop "pointer:Logitech G305" "Coordinate Transformation Matrix" 1, 0, 0, 0, 1, 0, 0, 0, 2.2
xinput set-prop "pointer:DELL0A78:00 04F3:3147 Touchpad" "Coordinate Transformation Matrix" 1, 0, 0, 0, 1, 0, 0, 0, 1.3
xinput set-prop "pointer:DELL0A78:00 04F3:3147 Touchpad" "Synaptics Scrolling Distance" -85 -85
xinput set-prop "pointer:DELL0A78:00 04F3:3147 Touchpad" "Synaptics Tap Action" 1 1 1 1 1 1 1

pacmd update-sink-proplist "alsa_output.pci-0000_03_00.1.HiFi__hw_Generic_3__sink" device.description=Monitor
pacmd update-sink-proplist "alsa_output.pci-0000_03_00.6.HiFi__hw_Generic_1__sink" device.description=Laptop
pacmd update-sink-proplist "alsa_output.pci-0000_03_00.1.HiFi__hw_Generic_7__sink" device.description=Unknown
