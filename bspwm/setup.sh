#!/usr/bin/env sh

if [ ! -e "$HOME/.config/polybar/colors" ]; then
    ln -s ./solarized-dark "$HOME/.config/polybar/colors"
fi
