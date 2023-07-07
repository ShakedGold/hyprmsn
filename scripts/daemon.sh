#! /bin/bash

hyprmsn=$HOME/.config/hyprmsn
mkdir $hyprmsn/windows 2> /dev/null
window=$(hyprctl activewindow -j | jq --raw-output .title)
rm -rf $hyprmsn/windows/*.jpeg 2> /dev/null

while true; do
    new_window=$(hyprctl activewindow -j | jq --raw-output .title)

    if [[ "$window" == "$new_window" ]]; then
     continue
    fi
    window=$new_window
    
    window_str=$(echo $window | sed -e 's/[]\/$*.^[]/\\&/g') #| sed 's/\[\([^]]*\)\]/\\[\1\\]/g') #add \ to []
    window_no_slash=$(echo $window | sed 's|/|⁄|g')
    
    at_size=$(hyprctl clients | sed -n "/$window_str/,/^\$/p" | grep -Ew 'at|size' | tr -d '[a-z]|:|\t| ')
    at=$(echo $at_size | tr ' ' '\n' | head -1 | tail -1)
    size=$(echo $at_size | tr ' ' '\n' | head -2 | tail -1 | tr ',' 'x')
    sleep 0.4
    grim -g "$at $size" -t jpeg -q 50 "$hyprmsn/windows/$window_no_slash.jpeg"
done
