# Rien Maertens's .bash_profile, based on
# Andrzej Szelachowski's .bash_profile

#####################
## Terminal Colors ##
#####################

# Reset (No Color)
NC='\[\e[0m\]'       # Text Reset

# Regular Colors
BLACK='\[\e[0;30m\]'        # Black
RED='\[\e[0;31m\]'          # Red
GREEN='\[\e[0;32m\]'        # Green
YELLOW='\[\e[0;33m\]'       # Yellow
BLUE='\[\e[0;34m\]'         # Blue
PURPLE='\[\e[0;35m\]'       # Purple
CYAN='\[\e[0;36m\]'         # Cyan
WHITE='\[\e[0;37m\]'        # White

# Bold
BBLACK='\[\e[1;30m\]'       # Black
BRED='\[\e[1;31m\]'         # Red
BGREEN='\[\e[1;32m\]'       # Green
BYELLOW='\[\e[1;33m\]'      # Yellow
BBLUE='\[\e[1;34m\]'        # Blue
BPURPLE='\[\e[1;35m\]'      # Purple
BCYAN='\[\e[1;36m\]'        # Cyan
BWHITE='\[\e[1;37m\]'       # White

# Underline
UBLACK='\[\e[4;30m\]'       # Black
URED='\[\e[4;31m\]'         # Red
UGREEN='\[\e[4;32m\]'       # Green
UYELLOW='\[\e[4;33m\]'      # Yellow
UBLUE='\[\e[4;34m\]'        # Blue
UPURPLE='\[\e[4;35m\]'      # Purple
UCYAN='\[\e[4;36m\]'        # Cyan
UWHITE='\[\e[4;37m\]'       # White

# Background
ON_BLACK='\[\e[40m\]'       # Black
ON_RED='\[\e[41m\]'         # Red
ON_GREEN='\[\e[42m\]'       # Green
ON_YELLOW='\[\e[43m\]'      # Yellow
ON_BLUE='\[\e[44m\]'        # Blue
ON_PURPLE='\[\e[45m\]'      # Purple
ON_CYAN='\[\e[46m\]'        # Cyan
ON_WHITE='\[\e[47m\]'       # White

# Red if root, else green.
PCT="\`if [[ \$EUID -eq 0 ]]; then T='$BRED' ; else T='$BGREEN'; fi; 
echo \$T \`"

SIGN="\`if [[ \$EUID -eq 0 ]]; then T='#' ; else T='$'; fi; echo \$T \`"

PS1="$BLUE[$NC $PCT\u$BLUE@$NC$BBLUE\h $BLUE]$NC $BCYAN\W$NC $PCT$SIGN $NC"

#Load .bashrc
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
