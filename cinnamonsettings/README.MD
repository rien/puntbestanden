From a terminal, run:

`dconf dump /org/cinnamon/ > mysettings`

save the `mysettings` file somewhere for later

to reset to defaults:

`dconf reset -f /org/cinnamon/`

Note, cinnamon may freeze or crash doing this

To restore all your settings:

`dconf load /org/cinnamon/ < mysettings`

Again, cinnamon may freeze crash after this (recommend at least logging out/back in)<Paste>
