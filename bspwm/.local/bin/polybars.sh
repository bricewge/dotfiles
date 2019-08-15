#!/usr/bin/env sh
#
# This script setup bspwm desktops and theirs status bar. It can be used
# by itself or as a postswitch hook for autorandr.

set -e

cleanup () {
    systemctl --user unset-environment TRAY_POSITION
}
trap cleanup INT QUIT TERM

if [ -n "$AUTORANDR_MONITORS" ]; then
    monitors=$(printf %s "$AUTORANDR_MONITORS" | tr ':' "\n")
else
    monitors=$(xrandr --query | awk '$2 ~ /^connected/ {print $1}')
fi

for monitor in ${monitors}; do
    if [ "$monitor" = "LVDS1" ]; then
        bspc monitor "$monitor" -d 1
        if [ "$(printf "%s\n" "$monitors" | wc -l)" -gt 1 ]; then
            systemctl --user set-environment  TRAY_POSITION=none
        fi
    else
        bspc monitor "$monitor" -d  8
        systemctl --user unset-environment TRAY_POSITION
    fi
    systemctl --user start "polybar@${monitor}.service"
done
