# -*- mode: sh -*-
xrdb ~/.Xresources
# Load terminus font for bar
xset +fp /usr/share/fonts/local
xset fp rehash

# Enable hotkeys
sxhkd &

# Set a wallpaper
feh --bg-fill ~/.dotfiles/wallpaper/schicka-307-unsplash.jpg &

#Set color temperature according to time of day
redshift &

# Hide the cursor when not used
unclutter -grab -noevents -root &

# Use a basic cursor
xsetroot -cursor_name left_ptr &

# Launch bspwm
exec bspwm 2> ~/.bspwm.log


