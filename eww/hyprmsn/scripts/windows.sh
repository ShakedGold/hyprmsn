#! /bin/bash
trun() {
    window=$1
    OLD_IFS="$IFS"
    IFS=$' '
    for word in $window; do
        if [[ $count == $word_per_line ]]; then
            str="$str$word\n"
            count=0
        else
            str="$str$word "
            count=$(($count + 1))
        fi
    done
    IFS=$OLD_IFS
    echo $str
}

img() {
    window=$1
    windows_images_dir=$HOME/.config/hyprmsn/windows
    window_no_slash=$(echo $window | sed 's|/|⁄|g')
    window_img="$windows_images_dir/$(ls $windows_images_dir | grep -F $window_no_slash | tail -1)"
    if [[ $window_img == "$windows_images_dir/" ]]; then
        window_img="$windows_images_dir/default.png"
    fi
    echo "$window_img"
}

word_per_line=3
echo "(box"
OLD_IFS="$IFS"
IFS=$'\n'
windows=$(hyprctl clients | rg 'Window ([A-Fa-f0-9]+)' | sed -E 's/.*\-> (.*):/\1/g')
classes=$(hyprctl clients | rg 'class: ' | sed "s/.*class: //g")

source $HOME/.config/hyprmsn/scripts/load_config.sh

i=1
for window in $windows; do
    window_class=$(echo $classes | tr ' ' '\n' | head -$i | tail -1)
    window_str=$(trun $window)
    window_img=$(img $window)

    if [ $use_icons == true ]; then
        find_icon=$(find /usr/share/icons/$icon_pack -iname "$window_class*" | head -4 | tail -1)
        if [[ $find_icon == "/usr/share/icons/$icon_pack" ]]; then
            window_img=$(img $window)
        fi
        window_img=$find_icon
    else
        window_img=$(img $window)
    fi

    #echo $window_img
    eww="(box :orientation \"v\" :class \"window-box\" (image :path \"$window_img\" :image-width 192 :image-height 108) (button :onclick \"$HOME/.config/eww/hyprmsn/scripts/move_to_window.sh \'$window\'\" :class \"window-button\" (box :orientation \"v\" "
    for string in $(echo -e $window_str); do
        eww="$eww $(echo -e "(label :text \"$string\")")"
    done
    eww="$eww)))"
    echo $eww

    i=$(( $i + 1 ))
done
IFS=$OLD_IFS
echo ")"
