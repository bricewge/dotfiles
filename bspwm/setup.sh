#!/usr/bin/env sh

if [ ! -e "$HOME/.config/polybar/colors" ]; then
    ln -s ./solarized-dark "$HOME/.config/polybar/colors"
fi

# Disable chromium decorations
chromium_config=$HOME/.config/chromium/Default/Preferences
if [ -e "$chromium_config" ]; then
    jq < "$chromium_config" .browser.custom_chrome_frame=false \
        > /tmp/tmpfile && mv --force /tmp/tmpfile "$chromium_config"
fi
