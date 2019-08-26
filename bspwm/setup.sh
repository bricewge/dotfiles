#!/usr/bin/env sh

# shellcheck disable=SC1090
. "${DOTFILES:-.}/shell/.shell/lib/utils.sh"

# Disable chromium decorations
chromium_config=$HOME/.config/chromium/Default/Preferences
if [ -e "$chromium_config" ]; then
    jq < "$chromium_config" .browser.custom_chrome_frame=false \
        > /tmp/tmpfile && mv --force /tmp/tmpfile "$chromium_config"
fi

# Set default theme
if [ ! -e "$XDG_CONFIG_HOME/theme/current-theme" ]; then
    symlink ./solarized/dark.m4 "$XDG_CONFIG_HOME/theme/current-theme"
fi
