#
# ~/.bash_profile
#

# Start X at login
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
