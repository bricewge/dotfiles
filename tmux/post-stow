#!/bin/sh

# shellcheck disable=SC1090
. "${DOTFILES:-.}/shell/.shell/lib/utils.sh"

plugins_dir=$HOME/.tmux/plugins
# WAITING https://github.com/tmux-plugins/tpm/pull/158
# repository https://github.com/tmux-plugins/tpm.git \
repository https://github.com/rafalrothenberger/tpm.git \
    "$plugins_dir/tpm" \
    add-branch-to-plugin
"$plugins_dir/tpm/bin/install_plugins"

# set default theme
symlink "$HOME/.tmux/themes/solarized-dark.conf" "$HOME/.tmux/current-theme.conf"
