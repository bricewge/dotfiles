#!/usr/bin/env sh
#
# Script executed when bspwm is started.

# shellcheck disable=SC1090
. "$HOME/.xprofile"
. "$HOME/.profile"

# * Early setup
# Setup monitors
autorandr --change --force
# Set a wallpaper
if [ -x "${XDG_CONFIG_HOME:=$HOME/.config}/setroot/.setroot-restore" ]; then
    setroot --restore &
else
    setroot --store --blank-color 'COLOR_BACKGROUND_ALT' \
        --on 0 -z \
        "${DOTFILES:=$HOME/.dotfiles}/bspwm/_wallpaper/nenuphar.jpg" \
        --on 1 -z \
        "$DOTFILES/bspwm/_wallpaper/nenuphar.jpg" &

fi
# Set a nice cursor
xsetroot -cursor_name left_ptr

# ** sxhkd
SXHKD_FIFO=${HOME}/.sxhkd.fifo
[ -e "$SXHKD_FIFO" ] && rm "$SXHKD_FIFO"
mkfifo "$SXHKD_FIFO"
sxhkd -s "$SXHKD_FIFO" -t 2 -r "$XDG_CACHE_HOME/sxhkd.log" &
sxhkd-listener.sh &

# * bspwm config
bspc monitor LVDS1 -d 0

bspc config remove_disabled_monitors true
bspc config merge_overlapping_monitors true

bspc config top_padding \
    "$(awk '$1~/^height$/ {print $3}' < "$XDG_CONFIG_HOME/polybar/config")"

export BSPWM_GAP=${BSPWM_GAP:=16}
bspc config window_gap 0
bspc config split_ratio 0.52
bspc config borderless_monocle true
bspc config gapless_monocle true

# ** borders
bspc config border_width 2
bspc config normal_border_color "COLOR_FOREGROUND_ALT"
bspc config active_border_color "COLOR_SECONDARY"
bspc config focused_border_color "COLOR_PRIMARY"
bspc config presel_feedback_color "COLO_BACKGROUND_ALT"

# ** windows rules
bspc config external_rules_command "$XDG_CONFIG_HOME/bspwm/external-rules"

# TODO move them to external rules
bspc rule -a 'Nightly:*' state=floating # Firefox
bspc rule -a Nightly:Navigator state=tiled

# ** listeners
# scripts that subscribe to bspwm events

# blur wallpaper of occupied displays
wallpaper-blur &

# To manage the desktops dynamically when remove the empty and unocupied
# ones.
"$XDG_CONFIG_HOME"/remove_empty_desktop &

# * other stuff to start
scu restart redshift &
# run polybars on all monitors
polybars.sh

xrdb ~/.Xresources

# Hide the cursor when not used
xbanish -i Mod4 &
# Fancy things *BUT* with too much bugs
# compton &
udiskie --notify &
# disable DPMS
xset s off -dpms
