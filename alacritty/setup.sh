#!/usr/bin/env sh

# WAITING emacs 27 won't need xterm-24 bit anymore
tic -x -o ~/.terminfo "$DOTFILES/emacs/_xterm-24bits.terminfo"
tic -x -o ~/.terminfo ./_alacritty.terminfo
