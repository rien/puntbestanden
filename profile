# If not running interactively, do nothing
[[ $- != *i* ]] && return

MANPATH="/home/rien/.local/share/man:$MANPATH"

JAVA_HOME="/usr/lib/openjdk"

# A more unclutttered way of defining custom PATHs
PATHS=(
    "/home/rien/.local/bin/"
    "/home/rien/.cargo/bin"
    # "/home/rien/.cabal/bin"
    "/home/rien/.rbenv/bin"
    "/home/rien/.anyenv/bin"
    "/home/rien/Development/Android/SDK/tools/bin"
    "/home/rien/Development/Android/SDK/platform-tools"
)

# Ofcourse, append it to the original PATH
PATHS+=("$PATH")

# Join all the paths
export PATH=$(IFS=: ; echo "${PATHS[*]}")

# Different aliases and inits for servers and clients
if [[ -z "$SSH_CONNECTION" ]]
then
## CLIENT ##

    # Automatically start X when logged in
    if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
        startx || vlock
        exit
    fi

    ZSH_TMUX_AUTOSTART=false
    [[ $TMUX == "" ]] && tmux new-session -A

    alias windoos='/home/rien/virtual/win10/windoos.sh'

    # Open stuff
    alias o='xdg-open'

    # Share Interwobles
    alias ap='sudo create_ap wlp3s0 enp4s0 Interwubs $(zenity --password)'

    # Start a webserver
    alias serve='python3 -m http.server 6969'

    # Matlab CLI
    alias matlab='/opt/Matlab/bin/matlab -nodesktop -nosplash'

    # Steam
    alias steam="LD_PRELOAD='/usr/\$LIB/libstdc++.so.6 /usr/\$LIB/libgcc_s.so.1 /usr/\$LIB/libxcb.so.1 /usr/\$LIB/libgpg-error.so' /usr/bin/steam  > /dev/null 2>&1 &"

    # Clipboard stuff
    alias showclip='xclip -o -sel clip'
    alias paste='xclip -o -sel clip >'
    alias clip='xclip -sel clip <'

    # Zeus
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
    alias adbrestart='adb kill-server && adb start-server'

    # <3 HTTPie
    alias https='http --default-scheme=https'


    [[ $(type rm) == "*alias*" ]] && unalias rm 2>&1 > /dev/null || true
    # Interactive rm function: always show what is going to be removed
    #function rm {
    #    local nodes=()
    #    for arg in "$@"
    #    do
    #        if /usr/bin/grep -qv '^-' <<< "$arg"
    #        then
    #            nodes+=("$arg")
    #            if [ -d "$arg" ]
    #            then
    #                /usr/bin/tree -Csauh --du "$arg"
    #            else
    #                /usr/bin/ls -FCsh "$arg"
    #            fi
    #        fi
    #    done

    #    # Show total size of the files
    #    /usr/bin/du -csh ${nodes[@]} | tail -n1

    #    # Ask confirmation
    #    echo 'remove[y/N]?' | tr -d '\012'
    #    read

    #    if [ "_$REPLY" = "_y" ]
    #    then
    #        /bin/rm -rfv $@
    #    else
    #        echo '(cancelled)'
    #    fi
    #}
    #compdef rm=rm
else
## SERVER ##
    alias poweroff=" echo \"You know you\'re on a server, right?\""

fi
## COMMON ##

# Extract tarball
alias untar='tar -xzvf'

# UGent VPN
alias vu='sudo vpnc /root/vpnc.conf'
alias vd='sudo vpnc-disconnect'

# I AM A MONSTER
#alias emacs='emacsclient -t -s /tmp/emacs1000/server'
#alias e='emacs'
#alias nvim='emacs'

# Neovim!
alias vi='nvim'
alias vim='nvim'
alias nano='cat /dev/urandom'

# Git
alias gd='git diff'                     # Diff changes in working dir against latest commit
alias gdc='git diff --cached'           # Diff 'added' changes against latest commit'
alias gs='git status --short'           # Quick git status
alias gsd='git stash && git stash drop && echo "Want it back? git stash apply \$stash_hash"' # Clean working dir, but keeps a magic ref
alias ga='git add -vu'                  # Add all tracked files
alias gA='git add -vA'                  # Add all tracked + untracked files
alias gc='git commit'                   # Simple commit
alias gcm='git commit -m'               # Simple commit with a message
alias gca='git commit -a'               # Add tracked files + commit
alias gcam='git commit -am'             # Add tracked files + commit with a message
alias gco='git checkout'                # Checkout
alias gcob='git checkout -b'            # Checkout to a new branch
alias gpp='git pull && git push'        # Never forget to pull first
alias gpu='git push -u origin $(git status -sb | head -n1 | cut -c 4-)' # git push -u origin <BRANCHNAME>
alias gppr='git pull --rebase && git push' # Pull with rebase
alias gpf='git push --force-with-lease && echo "YOU MONSTER!"' # A cleaner alternative
alias gl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all" # Pretty logs

# Run these commands in interactive mode:
alias cp='cp -iv'
alias mv='mv -iv'
# Prevents accidentally clobbering files.
alias mkdir='mkdir -p'

# Easier directory jumping
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Colored grepping
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
alias la='ll -A'           #  Show hidden files.

# Human readable sizes for du and df
alias du="du -h"
alias df="df -h"

# Other
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...
alias lr='tree'            #  Recursive ls
alias bc='bc -l'           #  Always import the standard math library
alias off='sudo poweroff'  #  Don't accidentally shut down severs

# Calculate stuff with bc faster
# Usage: ebc '1 + 1'
function ebc {
    echo $1 | bc -l
}


# Init some things
eval "$(thefuck --alias)"
eval "$(rbenv init -)"
eval "$(anyenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Environment variables
export DEFAULT_USER=rien
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export PAGER=/usr/bin/less
export TERMINAL=/home/rien/.local/bin/st
