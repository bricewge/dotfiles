emacs_diff() {
    emacsclient -nc -a "" --eval "                                 \
        (progn                                                     \
            (diff \"$1\" \"$2\")                                   \
            (delete-other-windows (get-buffer-window \"*Diff*\"))) "
}

# Shortcut for emacs editor
alias emacs="TERM=xterm-24bit emacs"
alias ec='emacsclient -t -a ""'
alias ecg='emacsclient -nc -a ""'
alias ediff=emac_-diff
