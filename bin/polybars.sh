#!/usr/bin/env sh

# This script setup bspwm desktops and theirs status bar. It can be used
# by itself or as a postswitch hook for autorandr.

if [[ -n ${AUTORANDR_MONITORS} ]]; then
    monitors=${AUTORANDR_MONITORS}
else
    monitors=$(xrandr --query | awk '/ connected / {print $1}')
fi

for monitor in ${monitors//:/ }
do
    if [[ "${monitor}" == "LVDS1" ]]; then
        bspc monitor "${monitor}" -d I II III IV V
    else
        bspc monitor "${monitor}" -d 1 2 3 4 5
    fi
    systemctl --user start "polybar@${monitor}"
done
