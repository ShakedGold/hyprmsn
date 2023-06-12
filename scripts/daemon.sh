#! /bin/bash

missioncontroldir=$HOME/.config/hyprmsn
mkdir $missioncontroldir/windows 2> /dev/null
window=$(hyprctl activewindow -j | jq --raw-output .title)
rm -rf $missioncontroldir/windows/* 2> /dev/null

while true; do
    new_window=$(hyprctl activewindow -j | jq --raw-output .title)
    new_window=$(echo $new_window | sed 's/\[\([^]]*\)\]/\\[\1\\]/g') #add \ to []
    new_window=$(echo $new_window | sed -E 's/(['\''\.\*\\^])/\\\1/g') #add \ to special characters
    new_window=$(echo $new_window | sed -E 's/([\{\}])/\\\1/g') #add \ to { and }

    if [[ "$window" == "$new_window" ]]; then
     continue
    fi
    window=$new_window

    
    at_size=$(hyprctl clients | sed -n "/$window/,/^\$/p" | grep -Ew 'at|size' | tr -d '[a-z]|:|\t| ')
    at=$(echo $at_size | tr ' ' '\n' | head -1 | tail -1)
    size=$(echo $at_size | tr ' ' '\n' | head -2 | tail -1 | tr ',' 'x')

    sleep 0.4
    grim -g "$at $size" -t jpeg -q 50 "$missioncontroldir/windows/$window.jpeg"
done
