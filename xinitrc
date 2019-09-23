#!/bin/bash

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Background
#feh --bg-fill ~/Pictures/Wallpapers/Space/meteormountains_better.png || true
feh --bg-fill ~/Pictures/mosaic_small169.png || true

# 'Reset' display and fix whites
xrandr --output eDP1 --off && xrandr --output eDP1 --mode 1920x1080 --brightness 0.9

# Fix keyboard
setxkbmap -layout us -variant alt-intl

# Fix backlight
xbacklight -set 100

# Keyboard repeat delay and rate
xset r rate 175 75

# Forking graphical programs
forklog() {
    $* 2>&1 | logger &
}

forklog xautolock -time 5 -locker lock.sh -notify 5
forklog bar
forklog rambox

exec dwmdb

