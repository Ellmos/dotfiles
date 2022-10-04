#!/bin/bash

WM_DESKTOP=$(xdotool getwindowfocus)

if [ $WM_DESKTOP == "2097251" ]; then

	echo ""

elif [ $WM_DESKTOP != "1883" ]; then

	WM_CLASS=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk 'NF {print $NF}' | sed 's/"/ /g')
	WM_NAME=$(xprop -id $(xdotool getactivewindow) WM_NAME | cut -d '=' -f 2 | awk -F\" '{ print $2 }')

    if [[ $WM_NAME == *'YouTube'* ]]; then

		echo "%{F#ffffff}Youtube%{u-}"

	elif [ $WM_CLASS == 'Brave-browser' ]; then

		echo "%{F#ffffff}Brave%{u-}"
        
    elif [ $WM_CLASS == 'discord' ]; then

		echo "%{F#ffffff}Discord%{u-}"
	
	else

		echo "%{F#ffffff}$WM_NAME%{u-}"

	fi

fi
