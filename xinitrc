#!/bin/bash

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Background
feh --bg-fill ~/Pictures/Wallpapers/Space/meteormountains_better.png || true

# Fix whites
xrandr --output eDP1 --brightness 0.9

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
forklog bar.rb
forklog rambox

exec dwmdb

