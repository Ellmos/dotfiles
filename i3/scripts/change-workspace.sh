#! /usr/bin/env bash

set -eu

activeWp=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num')
activeWpIndex=0
    
wps=()
for i in $(i3-msg -t get_workspaces | jq ".[] | .num")
do
    wps[${#wps[@]}]=$i
done


j=0
for i in ${wps[@]}
do
    if [[ $i == $activeWp ]]; then
        activeWpIndex=$j
    fi;
    j=$((j+1))
done

len=${#wps[@]}
len=$((len-1))


if [[ $1 == "next" ]]; then
    if [[ $activeWpIndex < $len ]]; then
        j=$((activeWpIndex+1))
        next=${wps[j]}
        i3-msg -q workspace number $next
    fi;

elif [[ $1 == "previous" ]]; then
    if [[ $activeWpIndex > 0 ]]; then
        j=$((activeWpIndex-1))
        prev=${wps[j]}
        i3-msg -q workspace number $prev
    fi;
fi;

exit 0
