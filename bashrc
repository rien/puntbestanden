# If not running interactively, don't do anything
[ -z "$PS1" ] && return
PATH="$(ruby -e 'print Gem.user_dir')/bin:/home/rien/Android/Sdk/platform-tools:/home/rien/Development/Android/CM13/bin:$PATH"

#Paden
alias folo='cd /home/rien/Development/FoLo/Project-FL/'
alias db='cd /home/rien/Development/DB/DB-Project/'


#lol
alias cat='lolcat'

#Systemctl
alias sctl='sudo systemctl'

#Zeus Music
alias mocz='PULSE_SERVER=ZEVEN mocp'

#Toon CPU
alias watchcpu='watch grep \"cpu MHz\" /proc/cpuinfo'

alias noturbo='echo 1 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo'
alias turbo='echo 0 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo'
alias powersave='sudo cpupower frequency-set -g powersave && noturbo'
alias performance='sudo cpupower frequency-set -g performance && turbo'
alias normal='sudo cpupower frequency-set -g powersave && turbo'

#Wireless Bridge (AP)
alias accespoint='sudo create_ap -m bridge wlp3s0 ### JitePlekke wachtebitje'

#UGent VPN
alias vu='sudo vpnc /root/vpnc.conf'
alias vd='sudo vpnc-disconnect'

#Run these commands in interactive mode:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'

# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h --color'
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
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...
alias bc='bc -l'
