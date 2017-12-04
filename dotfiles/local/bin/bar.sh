#!/bin/bash

# Kill a previously running instance
pkill -o "$0"

# The hotness
temp(){
    echo -n "$(sensors | sed -n '3s/.*+\(.*\)°C  (.*/\1/p')℃"
}

# The interwebz
connection(){
    result="$(iw dev wlp58s0 link)"
    if [[ $result == *"Not connected."* ]]; then
        result="⊥"
    else
        result=$(echo -n "$result" | sed -n "2s/.*SSID: \(.*\)/ 📡 [\1]/p")
    fi
    echo -n "$result"
}

# The time
datetime(){
    date +'%a %d %b, %H:%M'
}

# The juice
battery(){
    echo -n "⚡ $(acpi -b | tr -d ' ' | cut -d, -f2)"
}

# Glueing it all together
join() {
    # $1 is return variable name
    # $2 is sep
    # $3... are the elements to join
    local retname=$1 sep=$2 ret=$3
    shift 3 || shift $(($#))
    printf -v "$retname" "%s" "$ret${@/#/$sep}"
}

# The loopy loopy
while sleep 1; do
    join bar "  |  " "$(connection)" "$(temp)" "$(battery)" "$(datetime)"
    xsetroot -name "$bar"
done
