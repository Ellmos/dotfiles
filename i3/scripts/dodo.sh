#!/bin/sh

while true; do
    aklog
    i3lock -p win -i ~/.config/i3/img/lock/japanNight.png
    SECONDS=0
    while [ $SECONDS -lt 3180 ];do
        if [ $(ps aux | grep i3lock | wc -l) -eq 1 ]; then
            exit
        fi
    done
    aklog
    killall i3lock
done
