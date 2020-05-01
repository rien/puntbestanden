#!/bin/bash

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Background
feh --recursive --randomize --bg-fill "$HOME/Pictures/Wallpapers/Simon Stålenhag/" || true

# 'Reset' display and fix whites
xrandr --output eDP1 --off \
    && xrandr --output eDP1 --mode 1920x1080 --brightness 0.9

# Fix keyboard
setxkbmap -layout us -variant alt-intl -option caps:none

# Fix backlight
xbacklight -set 100

# Keyboard repeat delay and rate
xset r rate 175 75

exec dwmdb

