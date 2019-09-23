# Inspired by https://github.com/NoctuaNivalis/dotfiles/blob/master/bashrc

# Colors
# The \001 and \002 are more universal than the bash-only \[ and \] to escape color sequences
RED_="\001$(tput setaf 1)\002"
GREEN_="\001$(tput setaf 2)\002"
YELLOW_="\001$(tput setaf 3)\002"
BLUE_="\001$(tput setaf 4)\002"
PURPLE_="\001$(tput setaf 5)\002"
WHITE_="\001$(tput setaf 7)\002"
RESET_="\001$(tput sgr0)\002"

# keep the current return status ($?) while executing another command
ks() { s="$?" ; $* ; return "$s" ; }

prompt_pwd() {
    pwd | sed -e "s_${HOME}_~_" -e 's_\(/*\.*.\)[^/]*/_\1/_g'
}

prompt_git() {
    if git status 2>/dev/null 1>&2; then

        local branch="$(git branch | sed -n 's/^\* (*\(.* \)*\([^ )]*\))*$/\2/p' | tail -1)"
        local status="$(git status --branch --porcelain=2) "
        local added="$(sed -n 's/^[12] M.*$/✚ /p' <<< $status | tail -1)"
        local before="$(sed -n 's/^# branch\.ab +\([^0].*\) .*$/⬆ /p' <<< $status | tail -1)"
        local behind="$(sed -n 's/^# branch\.ab.*-\([^0].*\)$/⬇ /p' <<< $status | tail -1)"
        local deleted="$(sed -n 's/^[12] D.*$/✖ /p' <<< $status | tail -1)"
        local modified="$(sed -n 's/^[12] .M.*$/✱ /p' <<< $status | tail -1)"
        local unmerged="$(sed -n 's/^u/⚠ /p' <<< $status | tail -1)"
        local untracked="$(sed -n 's/^?.*$/◼ /p' <<< $status | tail -1)"

        printf "$GREEN_%s$RED_%s$GREEN_%s$BLUE_%s$RED_%s$WHITE_%s$PURPLE_%s%s" \
               "$branch" "$unmerged" "$added" "$modified" "$deleted" "$untracked" "$behind" "$before"
    fi
}

# echo the return status if not 0
prompt_status() {
    [ $? -eq 0 ] || echo -ne " $? "
}

export PS1="$BLUE_\$(ks prompt_pwd) \$(ks prompt_git)$RED_\$(prompt_status)$YELLOW_❯❯❯ $RESET_"

complete -c man
complete -cf sudo
complete -cf exec
complete -cf run

# history
shopt -s histappend
export HISTCONTROL=ignorespace:erasedups
export HISTSIZE=
export HISTFILESIZE=
PROMPT_COMMAND='history -a'


# Load aliasses and other stuff
if [ -r ~/.profile ]; then
    . ~/.profile
fi

setup_completions(){
    local completions_enabled=(
        "bundler"
        "git"
        "go"
        "makefile"
        "npm"
        "nvm"
        "pip"
        "pip3"
        "ssh"
    )
    for comp in "${completions_enabled[@]}"; do
        source "$HOME/.completions/$comp.completion.bash"
    done
}

setup_completions



PATH="/home/rien/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/rien/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/rien/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/rien/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/rien/perl5"; export PERL_MM_OPT;
