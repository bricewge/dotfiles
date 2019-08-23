#!/usr/bin/env sh

# shellcheck disable=SC1090
. "${DOTFILES:-.}/shell/.shell/lib/utils.sh"

# WAITING emacs 27 won't need xterm-24 bit anymore
tic -x -o ~/.terminfo "${DOTFILES:=.}/emacs/_xterm-24bits.terminfo"
tic -x -o ~/.terminfo "$DOTFILES/alacritty/_alacritty.terminfo"

# Using an indirect symlink as alacritty's config file allow us to siwtch theme
# variant without touching of the default value in the dotfiles.
theme=$(readlink "$XDG_CONFIG_HOME/alacritty/alacritty.yml")
if [ ! "$(dirname "$theme")" =  "$XDG_CONFIG_HOME/alacritty" ]; then
    symlink "$XDG_CONFIG_HOME/alacritty/solarized.yml" \
        "$XDG_CONFIG_HOME/alacritty/alacritty.yml"
fi
