# Inspired by https://github.com/NoctuaNivalis/dotfiles/blob/master/bashrc

# Colors
RED_="$(tput setaf 1)"
GREEN_="$(tput setaf 2)"
YELLOW_="\[$(tput setaf 3)\]"
BLUE_="$(tput setaf 4)"
PURPLE_="$(tput setaf 5)"
WHITE_="$(tput setaf 7)"
RESET_="\[$(tput sgr0)\]"

ks() { s="$?" ; $* ; return "$s" ; }

prompt_git() {
    if git status 2>/dev/null 1>&2; then

        local branch=$(git branch | sed -n 's/^\* (*\(.* \)*\([^ )]*\))*$/\2/p')
        local status=$(git status --branch --porcelain=2)
        local added=$(sed -n 's/^[12] M.*$/✚ /p' <<< $status | tail -1)
        local before=$(sed -n 's/^# branch\.ab +\([^0].*\) .*$/⬆ /p' <<< $status)
        local behind=$(sed -n 's/^# branch\.ab.*-\([^0].*\)$/⬇ /p' <<< $status)
        local deleted=$(sed -n 's/^[12] D.*$/✖ /p' <<< $status | tail -1)
        local modified=$(sed -n 's/^[12] .M.*$/✱ /p' <<< $status | tail -1)
        local unmerged=$(sed -n 's/^u/⚠ /p' <<< $status | tail -1)
        local untracked=$(sed -n 's/^?.*$/◼ /p' <<< $status | tail -1)

        local git_parts=(
            "$GREEN_$branch "
            "$RED_$unmerged"
            "$GREEN_$added"
            "$BLUE_$modified"
            "$RED_$deleted"
            "$WHITE_$untracked"
            "$PURPLE_$behind$before"
        )
        echo -en "$(IFS='' ; echo -en "${git_parts[*]}")"
    fi
}

prompt_pwd() {
    pwd | sed -e "s_${HOME}_~_" -e 's_\(/*\.*.\)[^/]*/_\1/_g'
}

prompt_status() {
    [ $? -eq 0 ] || echo "$? "
}

prompt_ps1(){
    local prompt_parts=(
        "$BLUE_\$(ks prompt_pwd) "
        "\$(ks prompt_git)"
        "$RED_\$(prompt_status)"
        "$YELLOW_❯❯❯"
    )
    echo "$(IFS='' ; echo "${prompt_parts[*]}") $RESET_"
}

export PS1="$(prompt_ps1)"

# Completion
_comp_git() {
    local IFS=$'\n'
    # $1 is the name of the command whose arguments are being completed
    # $2 is the word being completed
    # $3 is the word preceding the word being completed

    # branch names
    COMPREPLY=( $(git branch -a --format "%(refname:short)" | grep "^$2") )

    # remotes
    COMPREPLY+=( $(git remote | grep "^$2") )

    # files
    COMPREPLY+=( $(git ls-files -co --exclude-standard "$2*" | sed "s?\($2[^/]*\).*?\1?") )

    # subcommands
    if [ "$3" = "git" ]; then
        COMPREPLY+=( $({ compgen -c "git-"; command ls /usr/libexec/git-core; } | sed -n 's/^git-//p' | grep "^$2") )
    fi
}

complete -c man
complete -cf sudo
complete -cf exec
complete -cf run
complete -o filenames -F _comp_git git

# history
export HISTCONTROL=ignorespace:erasedups


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

