#! /bin/bash

config=$HOME/.config/hyprmsn/config.ini

section() {
    section_name=$1

    sed -n "/\[$section_name\]/,/^$/p" $config | sed -E "s/\[.*\]//g" | sed '/^[[:space:]]*$/d'
}

# daemon section
section daemon > /dev/null

# SOURCING
# support comments
sed "s/;/#/g" $config | grep -Ev "\[.*\]" | source /dev/stdin

# remove spaces
source <(grep = $config | sed 's/ *= */=/g')