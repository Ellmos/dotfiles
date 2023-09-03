#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
    echo "%{F#66ffffff} Off"
else 
    if [ $(echo info | bluetoothctl | grep 'Device' | wc -c) -eq 0 ]
    then 
        echo "" "%{F#66ffffff}On"
    fi
    name=$(echo info | bluetoothctl | grep "Name:" | cut -d' ' -f2- )
    echo "" $name
fi

