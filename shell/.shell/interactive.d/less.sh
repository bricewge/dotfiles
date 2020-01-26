# Settings for `less`.
# Theme from: https://github.com/zlsun/solarized-man
# Implementation from: https://unix.stackexchange.com/a/147

# shellcheck disable=SC2155

# NOTE `bold` make use of the bright colors

# blink
export LESS_TERMCAP_mb=$(tput bold; tput setaf 1)
# bold
export LESS_TERMCAP_md=$(tput bold; tput setaf 1)
# exit
export LESS_TERMCAP_me=$(tput sgr0)
# standout
export LESS_TERMCAP_so=$(tput smso; tput bold; tput setaf 2; tput setab 7)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# underline
export LESS_TERMCAP_us=$(tput smul;  tput setaf 2)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)

export LESS="--RAW-CONTROL-CHARS --mouse"
export GROFF_NO_SGR=1
export PAGER=less
