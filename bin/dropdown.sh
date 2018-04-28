#!/usr/bin/env sh

bspc rule --add TermiteDropdown sticky=on floating=on hidden=on
#bspc node  48234499 --flag hidden
#termite --class TermiteDropdown --geometry=`xdotool getdisplaygeometry | awk '{ print $1"x"$2/3 }'` &



# grab the window ID of the urxvt-quake terminal window
# WINID=`wmctrl -lx | grep termite.Dropdown | awk '{ print $1 }'`
wid=`xdotool search --limit 1 --class '^TermiteDropdown$'`

# if no existing window, start the terminal
if [ -z "$wid" ]; then
    TermiteSize=`xdotool getdisplaygeometry | awk '{ print $1"x"$2/3 }'`
    termite --class TermiteDropdown --geometry=$TermiteSize &
else # toggle hidden
   bspc node $wid --flag hidden --state floating
fi
