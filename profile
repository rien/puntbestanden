
# If not running interactively, do nothing
[[ $- != *i* ]] && return
# Start in tmux
[[ -z "$TMUX" ]] && exec tmux
PATH="$(ruby -e 'print Gem.user_dir')/bin:/home/rien/.rbenv/bin:/home/rien/Android/Sdk/platform-tools:/home/rien/Development/Android/CM13/bin:/home/rien/scripts/:$PATH"

# Open stuff
alias o='xdg-open'

# Neovim!
alias vi='nvim'
alias vim='nvim'

# Matlab!
alias matlab='/opt/Matlab/bin/matlab -nodesktop -nosplash'

# Clipboard stuff
alias showclip='xclip -o -sel clip'
alias paste='xlip -o -sel clip >'
alias clip='xclip -sel clip <'

# Take a screeshot and upload it to my server
alias shot='bash ~/scripts/shot.sh'
alias shots='shot -s'

# Git
alias gs='git status --short'
alias gsh='git stash'
alias gshd='git stash drop'
alias ga='git add -vu'
alias gA='git add -vA'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcam='git commit -am'
alias gpp='git pull && git push'
alias gl="log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

# Zeus
alias mocz='PULSE_SERVER=ZEVEN cmus'
alias cmuz='PULSE_SERVER=ZEVEN cmus'
alias cammie='curl http://kelder.zeus.ugent.be/webcam/video/mjpg.cgi | mpv --no-correct-pts --fps 5 -'

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
alias rm='rm --interactive=once -v'
alias cp='cp -iv'
alias mv='mv -iv'
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
alias lm='ll | less'       #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.

# Other
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...
alias bc='bc -l'
alias off='sudo poweroff'  #  Don't accidentally shut down severs

# ebc '1 + 1'
# > 2
function ebc {
echo $1 | bc -l
}

# Init some things
eval $(thefuck --alias)
eval "$(rbenv init -)"

# Enviroment variables
export ANSIBLE_INVENTORY=~/Development/Sysadmin/Ansible/ansible_hosts
export DEFAULT_USER=rien
export EDITOR=/usr/bin/nvim
export TERMINAL=/usr/bin/urxvt
