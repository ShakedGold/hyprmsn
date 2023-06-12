# hyprmsn
A "Mission Control" like in macos for Hyprland

# Explanation
### ```daemon.sh```
this file is supposed to be running at all times and its purpose is to screenshot the focused window everytime you switch to a different window
video example:


### ```clients.sh```
This is a temporary file to use rofi for the UI but my plan is to switch this to eww to be able to display the images and control the appearance.
the file works by calling ```hyprctl clients``` and grabbing the title for each one, after that it will loop through and find the corresponding screenshot to display, then it will display the rofi menu and wait for a selection to be made, after the chosen window is selected, I get the window ID/Adress and use that with:
```
hyprctl dispatch focuswindow address:0x$window_id > /dev/null
```
to switch to the window

# Mission
My goal right now is to use eww to display the window switcher, I need to create a widget and programmatically use that widget for each window that is available (to get the windows I use ```htyprctl clients```).
Also I suck at scss/css in general so I need a bit of help!
If you would like to help me that would be awesome, the most important thing right now is dynamically generating the eww widget with the corresponding number of windows open.

# Dependencies
* Hyprland
* ```grim```

# Getting Started
To test the program you will need to do the following:
1. create a directory in "~/.config/" called "hyprmsn"
2. move the script folder there
3. run ./daemon.sh (explenation above)
4. (optional) run ./clients.sh
