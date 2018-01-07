#!/usr/bin/env sh

# Dirty script to setup my laptop when I use it as desktop
# TODO use umonitor to replace that

# Manually setup the monitors
~/.local/src/rofi-scripts/rofi-randr
sleep 3

# Use speakers connected to the monitor
xrandr --output HDMI1 --set "audio" off && xrandr --output HDMI1 --set "audio" on
pacmd set-card-profile 0 output:hdmi-stereo
