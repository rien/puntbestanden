#!/bin/bash

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Fix whites
xrandr --output eDP1 --brightness 0.9

# Fix keyboard
setxkbmap -layout us -variant alt-intl

# Fix backlight
xbacklight -set 100

# Keyboard repeat delay and rate
xset r rate 200 50

# Forking graphical programs
forklog() {
    $* 2>&1 | logger &
}

forklog xautolock -time 5 -locker lock.sh -notify 5
forklog bar.sh

rambox &
exec dwmdb

