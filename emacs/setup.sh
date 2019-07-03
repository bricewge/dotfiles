#!/usr/bin/env sh

# WAITING emacs 27 won't need xterm-24 bit anymore
tic -x -o ~/.terminfo ./_xterm-24bits.terminfo

# doom emacs
if [ ! -d ~/.emacs.d ]; then
    git clone https://github.com/hlissner/doom-emacs "$HOME/.emacs.d"
    "$HOME/.emacs.d/bin/doom" upgrade
fi
