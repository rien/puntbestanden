#!/bin/sh
killall -SIGUSR1 dunst # pause
setxkbmap -option srvrkeys:none # Disable VT switching
slock
setxkbmap -option '' # Enable VT switching again
killall -SIGUSR2 dunst # resume
