#!/bin/bash
# ~/.xinitrc - executed by startx

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xbindkeys # bind audio junk
setxkbmap -option caps:swapescape # switch caps and escape
xbacklight -set 50 # backlight default
xset r rate 300 30 # Set key delay (300ms) and rate (30 per sec??

# launch dwm
if command -v ranfeh > /dev/null; then
    ranfeh ~/images/desktops
fi
dwmstatus &
exec dwm
