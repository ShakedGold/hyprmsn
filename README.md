# hyprmsn
A "Mission Control" like in macos for Hyprland

# Explanation
### ```daemon.sh```
this file is supposed to be running at all times and its purpose is to screenshot the focused window everytime you switch to a different window
[Video Example](https://imgur.com/a/ExP51Ms)

### ```clients.sh```
This is a temporary file to use rofi for the UI but my plan is to switch this to eww to be able to display the images and control the appearance.
the file works by calling ```hyprctl clients``` and grabbing the title for each one, after that it will loop through and find the corresponding screenshot to display, then it will display the rofi menu and wait for a selection to be made, after the chosen window is selected, I get the window ID/Adress and use that with:
```
hyprctl dispatch focuswindow address:0x$window_id > /dev/null
```
to switch to the window

# Mission
- [x] Integrate eww to dynamically create widgets
- [ ] make eww pretty

# Dependencies
* Hyprland
* ```grim```

# Getting Started
To test the program you will need to do the following:
1. create a directory in `~/.config/` called `hyprmsn`
2. move the scripts folder to `~/.config/hyprmsn`
3. move the contents of the eww folder to `~/.config/eww/`
4. run `./daemon.sh` (explenation above)
5. run `eww open hyprmsn`
6. (optional) run `./clients.sh` (runs rofi)
