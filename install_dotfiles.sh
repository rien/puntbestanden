#!/bin/bash

ask() {
    # https://djm.me/ask
    local prompt default reply

    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read reply </dev/tty

        # Default?
        if [ -z "$reply" ]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

if ! ask "Do you want to install the dotfiles in $HOME?" N; then
    exit 1
fi

pwd=$(pwd)

for file in dotfiles/*; do
    base=$(basename "$file")
    if [[ "$base" != "config" && "$base" != "ssh" ]]; then
        echo "$pwd/$file -> $HOME/.$base"
        ln -si "$pwd/$file" "$HOME/.$base"
    fi
done
for cfile in dotfiles/config/*; do
    cbase=$(basename "$cfile")
    echo "$pwd/$cfile -> $HOME/.config/$cbase"
    ln -si "$pwd/$cfile" "$HOME/.$cbase"
done
for sfile in dotfiles/ssh/*; do
    sbase=$(basename "$sfile")
    echo "$pwd/$sfile -> $HOME/.ssh/$sbase"
    ln -si "$pwd/$sfile" "$HOME/.$sbase"
done
