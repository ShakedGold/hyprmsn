eww --config $HOME/.config/eww/hyprmsn/widgets open hyprmsn --arg monitor=$(hyprctl -j monitors | jq -r '.[] | select(."focused"==true).id')
