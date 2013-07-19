#!/bin/sh
# ~/.xinitrc - executed by startx

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xbindkeys # bind audio junk
# xmodmap -e 'clear Lock' -e 'keycode 66 = Escape NoSymbol Caps_Lock' # fuck caps lock - FIXME
xbacklight -set 50 # backlight default
xset r rate 300 30 # Set key delay (300ms) and rate (30 per sec??

# launch dwm
. ~/.fehbg
dwmstatus &
exec dwm
