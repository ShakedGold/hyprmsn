#! /bin/bash
trun() {
    window=$1
    OLD_IFS="$IFS"
    IFS=$' '
    for word in $window; do
        if [[ $count == $word_per_line ]]; then
            str="$str$word\n"
            count=0
            line_count=$(($line_count + 1))
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
total_lines=2
OLD_IFS="$IFS"
IFS=$'\n'
windows=$(hyprctl clients | rg 'Window ([A-Fa-f0-9]+)' | sed -E 's/.*\-> (.*):/\1/g')
classes=$(hyprctl clients | rg 'class: ' | sed "s/.*class: //g")
initial_names=$(hyprctl clients | rg 'initialTitle: ' | cut -d ' ' -f2-)

source $HOME/.config/hyprmsn/scripts/load_config.sh

result="["

i=1
for window in $windows; do
    window_class=$(echo $initial_names | tr ' ' '\n' | head -$i | tail -1)
    window_img=$(img $window)

    if [ $use_icons == true ]; then
        window_icon=$(find /usr/share/icons/$icon_pack | grep -E -i "$window_class\." | head -1 | tail -1)
    fi

    object="{\"name\": \"$window\", \"icon\": \"$window_icon\", \"image\": \"$window_img\", \"onclick\": \"../scripts/move_to_window.sh '$window'\"}"

    result=$(echo "$result$object,")

    i=$(( $i + 1 ))
done
IFS=$OLD_IFS

result=$(echo "$result" | sed 's/,$/]/g')

echo $result
