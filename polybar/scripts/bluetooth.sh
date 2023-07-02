#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
    echo "%{F#66ffffff}"
else 
    if [ $(echo info | bluetoothctl | grep 'Device' | wc -c) -eq 0 ]
    then 
        echo "" "%{F#66ffffff}No Device"
    fi
    name=$(echo info | bluetoothctl | grep "Name:" | cut -d' ' -f2- )
    echo "" $name
fi

