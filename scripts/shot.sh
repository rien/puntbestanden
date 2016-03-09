#!/bin/bash
set -e

user="rien"
hostname="glados"
location="/srv/http/ss.rxn.be"
webadress="http://ss.rxn.be"

# Make a random file
file="$(mktemp XXXX.png)"
# Save the server adress to the clipboard
echo "$webadress/$file" | xclip -sel clip
# Take a screenshot with the user's arguments
escrotum $* "$file" > /dev/null 2>&1 
# Make the file secure
chmod 644 $file
# Push the screenshot to the server
scp -p $file $user@$hostname:$location/$file
# Notify the user
notify-send "Screenshot taken: $webadress/$file"
# Remove the temporary file
rm -f $file
