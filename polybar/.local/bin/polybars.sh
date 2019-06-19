#!/usr/bin/env sh

# This script setup bspwm desktops and theirs status bar. It can be used
# by itself or as a postswitch hook for autorandr.

set -x

if [ -n "$AUTORANDR_MONITORS" ]; then
    monitors=$(printf %s "$AUTORANDR_MONITORS" | tr ':' "\n")
else
    monitors=$(xrandr --query | awk '$2 ~ /^connected/ {print $1}')
fi

for monitor in ${monitors}; do
    # TODO Remove handwritten monitor names
    if [ "$monitor" = "LVDS1" ]; then
        bspc monitor "$monitor" -d I II III IV V
    else
        bspc monitor "$monitor" -d 1 2 3 4 5
    fi
    systemctl --user start "polybar@${monitor}.service"
done
