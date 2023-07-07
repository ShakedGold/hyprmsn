#! /bin/bash
hyprmsn=$HOME/.config/hyprmsn

OLDIFS="$IFS"
IFS=$'\n' # bash specific
chosen=$(for line in $(hyprctl clients | grep "title: " | sed 's/title: //g' | tr -d '\t')
do
    special_line=$line
    special_line=$(echo $special_line | sed 's/\[\([^]]*\)\]/\\[\1\\]/g') #add \ to []
    special_line=$(echo $special_line | sed 's/'\''\.\*\\^//g') #add \ to special characters
    icon=$(ls "$hyprmsn/windows" | grep -F $special_line)
    echo -en "$line\x00icon\x1f$hyprmsn/windows/$icon\n"
done | rofi -dmenu )
IFS="$OLDIFS"

window_id=$(hyprctl clients | rg 'Window ([A-Fa-f0-9]+)' | grep -F "$chosen" | sed -E 's/Window (.*)->.*/\1/g')
hyprctl dispatch focuswindow address:0x$window_id > /dev/null
