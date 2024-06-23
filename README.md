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

# Todo
- [x] Integrate eww to dynamically create widgets
- [X] make eww pretty
- [ ] remove unsused screenshots to save space

# Dependencies
* Hyprland
* grim
* eww
* jq
* rg

# New Features
* you can now choose to use icons instead on the daemon as images! (so now you dont have to run the daemon at startup)
  just go into config.ini and set use_icons to true, it works best with the Papirus icon theme

# Getting Started
To test the program you will need to do the following:
1. `git clone https://github.com/ShakedGold/hyprmsn`
2. make sure `installer.sh` is executable (`chmod +x installer.sh`)
3. run `installer.sh`
4. run daemon.sh in `~/.config/hyrpmsn/scripts`
5. run `eww --config $HOME/.config/eww/hyprmsn open hyprmsn`
