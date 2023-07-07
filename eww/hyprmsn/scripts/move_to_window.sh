window_id=$(hyprctl clients | rg 'Window ([A-Fa-f0-9]+)' | grep -F "$*" | sed -E 's/Window (.*) \->.*/\1/g')
hyprctl dispatch focuswindow address:0x$window_id > /dev/null
eww --config $HOME/.config/eww/hyprmsn close hyprmsn