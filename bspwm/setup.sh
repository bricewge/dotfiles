#!/usr/bin/env sh

# shellcheck disable=SC1090
. "${DOTFILES:-.}/shell/.shell/lib/utils.sh"

symlink ./solarized-dark "$HOME/.config/polybar/colors"

# Disable chromium decorations
chromium_config=$HOME/.config/chromium/Default/Preferences
if [ -e "$chromium_config" ]; then
    jq < "$chromium_config" .browser.custom_chrome_frame=false \
        > /tmp/tmpfile && mv --force /tmp/tmpfile "$chromium_config"
fi
