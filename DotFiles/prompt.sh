#!/bin/bash

################################################################
################# Alex Hahn's prompt script#####################
################################################################

# To use simply put a line in the bottom of your .bashrc (may have to create
# that in home folder)as "source ~/prompt.sh" with this file in the same
# folder

################################################################
#TODO's:
#           1) red only for same file conflict potential -Done
#           2) blue svn dir if changes made but not staged
#           3) refactor to see if you can leverage the .svn and index bnot need
#           to ping the remote repo twice... kinda laggy
################################################################

function __prompt
{
# Bash colors in a more convenient variable to use
local BLACK="\[\033[0;30m\]" # Black
local DGREY="\[\033[1;30m\]" # Dark Gray
local RED="\[\033[0;31m\]" # Red
local LRED="\[\033[1;31m\]" # Light Red
local GREEN="\[\033[0;32m\]" # Green
local LGREEN="\[\033[1;32m\]" # Light Green
local BROWN="\[\033[0;33m\]" # Brown
local YELLOW="\[\033[1;33m\]" # Yellow
local BLUE="\[\033[0;34m\]" # Blue
local LBLUE="\[\033[1;34m\]" # Light Blue
local PURPLE="\[\033[0;35m\]" # Purple
local LPURPLE="\[\033[1;35m\]" # Light Purple
local CYAN="\[\033[0;36m\]" # Cyan
local LCYAN="\[\033[1;36m\]" # Light Cyan
local LGREY="\[\033[0;37m\]" # Light Gray
local WHITE="\[\033[1;37m\]" # White

local RESET="\[\033[0m\]" # Color reset
local BOLD="\[\033[;1m\]" # Bold

# Base prompt
PS1="\[\e[33;1m\]\u@\H\[\e[35;1m\] Shell:\s\l \[\e[31;1m\]\d \@\[\e[37;1m\] This is command \#\n\[\e[32;1m\]\w\[\e[36;1m\] => \[\e[0m\]"
export PS2="| => "


local dirty
local branch
local updateable

# Look for Subversion status
if test -d .svn; then
    dirty=$(svn status -q)
    branch=$(svn info | grep URL | sed -e 's/.*\///')
    updateable=$(svn status -u | grep -E -c "^\s+[^\?]") # Can I use this for
    #local changed but remote same?? TODO: additional functionality
    #localChanges=$svn status -u
fi

if [[ ! -z "$branch" ]];
then
    local status_color
    # nothing staged to commit and remote dir not touched since last update
    if [[ -z "$dirty"  &&  "$updateable" -eq 0 ]];
    then
        status_color=$GREEN
    # Changes made locally and staged to push AND remote dir changed
    # (WARING this is the only time you can get a conflict, which is why
    # color will be red)
    elif [[ ! -z "$dirty" && "$updateable" -gt 0 ]];
    then
        status_color=$RED
    # no local changes to push but remote dir has been changed, consider
    # updating!
    elif [[ "$updateable" -gt 0 ]] ; then
        status_color=$YELLOW
    # local changes staged to commit and remote dir untouched since last
    # update (this commit will always succeed without conflict)
    else
        status_color=$WHITE
    fi
    PS1="$LCYAN($bold$status_color$branch$LCYAN) \[\e[33;1m\]\u@\h\[\e[35;1m\] \[\e[31;1m\]\d \@\[\e[37;1m\] command #\#\n\[\e[32;1m\]\w\[\e[36;1m\] => \[\e[0m\]"
fi
}

if [[ -z "$PROMPT_COMMAND" ]]; then
    PROMPT_COMMAND=__prompt
else
    PROMPT_COMMAND="$PROMPT_COMMAND; __prompt"
fi
__prompt
