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
    echo "$windows_images_dir/$(ls $windows_images_dir | grep -F $window)"
}

word_per_line=3
echo "(box"
OLD_IFS="$IFS"
IFS=$'\n'
windows=$(hyprctl clients | rg 'Window ([A-Fa-f0-9]+)' | sed -E 's/.*\-> (.*):/\1/g')
for window in $windows; do
    window_str=$(trun $window)
    window_img=$(img $window)
    eww="(box :orientation \"v\" :class \"window-box\" (image :path \"$window_img\" :image-width 192 :image-height 108) (button :onclick \"scripts/move_to_window.sh \'$window\'\" :class \"window-button\" (box :orientation \"v\" "
    for string in $(echo -e $window_str); do
        eww="$eww $(echo -e "(label :text \"$string\")")"
    done
    eww="$eww)))"
    echo $eww
done
IFS=$OLD_IFS
echo ")"