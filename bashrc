PATH="$(ruby -e 'print Gem.user_dir')/bin:/home/rien/Android/Sdk/platform-tools:/home/rien/Development/Android/CM13/bin:/home/rien/scripts/:$PATH"

# Open stuff
alias o='xdg-open'

# Neovim!
alias vim='nvim'

# Matlab!
alias matlab='/opt/Matlab/bin/matlab -nodesktop -nosplash'

# file to clipboard
alias clip='xclip -sel clip <'

# Take a screeshot and upload it to my server
alias shot='bash ~/scripts/shot.sh'
alias shots='shot -s'

# Systemctl
alias sctl='systemctl'

# Zeus Music
alias mocz='PULSE_SERVER=ZEVEN mocp'

# CPU Commands
alias watchcpu='watch grep \"cpu MHz\" /proc/cpuinfo'

alias noturbo='echo 1 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo'
alias turbo='echo 0 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo'
alias powersave='sudo cpupower frequency-set -g powersave && noturbo'
alias performance='sudo cpupower frequency-set -g performance && turbo'
alias normal='sudo cpupower frequency-set -g powersave && turbo'

# Android Debug Bridge
alias adbrestart='sudo adb kill-server && sudo adb start-server'
alias adb='sudo adb'

#UGent VPN
alias vu='sudo vpnc /root/vpnc.conf'
alias vd='sudo vpnc-disconnect'

#Run these commands in interactive mode:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'

# Easier directory jumping
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Color!
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'

# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h --color'
alias l='ls -Alhk'         #  Woopwoop
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.

# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lv --group-directories-first"
alias lm='ll | less'        #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.

# Other
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...
alias bc='bc -l'
alias off='sudo poweroff'

function ebc {
    echo $1 | bc -l
}

eval $(thefuck --alias)
