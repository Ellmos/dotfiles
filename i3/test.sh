#! /usr/bin/env bash

echo arg: $1
set -eu

activeWp=$(xdotool get_desktop)

len=$(xdotool get_num_desktops)
len=$((len-1))

if [[ $1 == "next" ]]; then
    echo "yas"
    if [[ $activeWp < $len ]]; then
        xdotool set_desktop --relative -- +1
    fi;

elif [[ $1 == "previous" ]]; then
    echo "nein"
    if [[ $activeWp > 0 ]]; then
        xdotool set_desktop --relative -- -1
    fi;
fi;
