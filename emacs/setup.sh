#!/usr/bin/env sh

# shellcheck disable=SC1090
. "${DOTFILES:-.}/shell/.shell/lib/utils.sh"

# WAITING emacs 27 won't need xterm-24 bit anymore
tic -x -o "$HOME/.terminfo" "${DOTFILES:-.}/emacs/_xterm-24bits.terminfo"

# doom emacs
# WAITING https://github.com/hlissner/doom-emacs/pull/1681
repository https://github.com/hlissner/doom-emacs \
    "$HOME/.emacs.d" \
    bricewge
"$HOME/.emacs.d/bin/doom" upgrade
