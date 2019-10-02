
export MANPATH="/home/rien/.local/man/:/home/rien/.local/share/man:$MANPATH"

export JAVA_HOME="/usr/lib/jvm/openjdk"
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

# A more unclutttered way of defining custom PATHs
PATHS=(
    "/home/rien/.local/bin/"
    "/home/rien/.cargo/bin"
    "/home/rien/.rbenv/bin"
    "/home/rien/.crenv/bin"
)

# Ofcourse, append it to the original PATH
PATHS+=("$PATH")

# Join all the paths
export PATH=$(IFS=: ; echo "${PATHS[*]}")

# Exit here if not running interactively (only PATH will have changed)
[[ $- != *i* ]] && return

# Different aliases and inits for servers and clients
if [[ -z "$SSH_CONNECTION" ]]
then
## CLIENT ##

    # Automatically start X when logged in
    if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
        startx || vlock
        exit
    fi

    [[ $TMUX == "" ]] && tmux new-session -A

    alias windoos='/home/rien/virtual/win10/windoos.sh'
    alias murder='pkill -9'

    # Thesis
    alias thesis='cd /home/rien/Unipept/thesis'
    export THESISDATA='/home/rien/Unipept/thesis/data/'

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
    alias paste='xclip -o -sel clip'
    alias clip='xclip -sel clip <'

    # Zeus
    alias cmuz='PULSE_SERVER=ZEVEN cmus'
    alias mpz='mpc -h hoek'
    alias mpr='mpc -h mpd.rumores.eu -p 6612 -P zeusisdemaks'
    alias cammie='curl http://kelder.zeus.ugent.be/webcam/video/mjpg.cgi | mpv --no-correct-pts --fps 5 -'
    alias resto='curl https://mattermore.zeus.gent/resto'
    alias zeuspass='PASSWORD_STORE_DIR=~/.zeus-wachtwoord-winkel pass'

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

    alias sun='xrandr --output eDP1 --brightness 1.1 && xrandr --output eDP1 --gamma 1.5:1.5:1.5'
    alias nosun='xrandr --output eDP1 --brightness 0.9 && xrandr --output eDP1 --gamma 1:1:1'

    alias goodmorning='xrandr  --output DP1 --auto --above eDP1'
    alias goodevening='xrandr  --auto'

    alias latexlive="latexmk -xelatex -latexoption='-interaction=nonstopmode -halt-on-error' -view=none -pvc"

    alias irc="ssh -t irc@bang abduco -A irc"

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
alias vu="sudo vpnc --script $HOME/.local/bin/vpnc-script"
alias vd='sudo vpnc-disconnect'

# Private VPN
alias privatevpn="sudo openvpn --config /etc/privatevpn.conf"
alias intigritivpn="sudo openvpn --config /etc/privatevpn-intigriti.conf"

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

# Exa is a cool alternative for ls
alias ls='exa'
alias l='exa -l --color-scale'
alias la='exa -la --color-scale'

# lr is also cool
alias ll="lr -1Glh"

# Human readable sizes for du and df
alias du="du -h"
alias df="df -h"

# Other
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...
alias q='qalc'            #  Qalculate! https://qalculate.github.io/
alias off='sudo poweroff'  #  Don't accidentally shut down severs

# Initialize z
source "$HOME/.local/bin/z.sh"

# Jump to a directory
d() {
    dir="$(lr /etc /home -t '(name ~~ ".*" && prune || print) && type = d && !(name = ".git")' \
          | fzf --height 10 \
          )"
    [ -n "$dir" ] && cd "$dir" || false
}

# Init some things
eval "$(thefuck --alias)"   2> /dev/null
eval "$(rbenv init -)"      2> /dev/null
eval "$(crenv init -)"      2> /dev/null

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Go stuff
export GOPATH="/home/rien/Development/Go/"

# John The Ripper
export JOHN=/home/rien/code/tools/john/run/
alias john="$JOHN/john"

# Environment variables
export DEFAULT_USER=rien
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export PAGER=/usr/bin/less
export TERMINAL=/home/rien/.local/bin/st
