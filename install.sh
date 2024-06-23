#! /bin/bash

# prerequisites
if ! command -v eww &> /dev/null
then
    echo "eww could not be found"
    echo "install eww-wayland to continue"
    exit
fi

if ! command -v grim &> /dev/null
then
    echo "grim could not be found"
    echo "install grim to continue"
    exit
fi

if ! command -v jq &> /dev/null
then
    echo "jq could not be found"
    echo "install jq to continue"
    exit
fi

if ! command -v rg &> /dev/null
then
    echo "rg could not be found"
    echo "install rg to continue"
    exit
fi


mkdir ~/.config/eww 2> /dev/null
echo "created eww dir if it didn't existed"
cp -r eww/* ~/.config/eww
echo "copied the hyprmsn folder to the eww config"
mkdir ~/.config/hyprmsn 2> /dev/null
echo "created the hyprmsn dir"
cp -r scripts windows ~/.config/hyprmsn/
echo "copied the scripts, windows to the hyprmsn dir"
cp config.ini ~/.config/hyprmsn/
echo "copied the config.ini to the hyprmsn dir"