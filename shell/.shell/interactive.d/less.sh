# Settings for `less`.
# Theme from: https://github.com/zlsun/solarized-man
# Implementation from: https://unix.stackexchange.com/a/147

# shellcheck disable=SC2155

# NOTE Based on your terminal settings `bold` may make use of the bright
# colors instead of the normal ones. For example it's the default for
# Alacritty's option "draw_bold_text_with_bright_colors".

# blink
export LESS_TERMCAP_mb=$(tput bold; tput setaf 1)
# bold
export LESS_TERMCAP_md=$(tput bold; tput setaf 1)
# exit
export LESS_TERMCAP_me=$(tput sgr0)
# standout
export LESS_TERMCAP_so=$(tput sgr0; tput smso; tput bold)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# underline
export LESS_TERMCAP_us=$(tput smul;  tput setaf 2)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)

export LESS="--RAW-CONTROL-CHARS --mouse"
export GROFF_NO_SGR=1
export PAGER=less
