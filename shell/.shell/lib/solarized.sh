#!/usr/bin/env sh
#
# Acces solarized colors by their name for terminal either supporting 24 bits
# colors or 16/256 colors. This is a workaround around 24 bits colors terminals
# where you can only access to the first 8 colors by their index.

while read -r var; do
    if [ "$COLORTERM" = truecolor ] || [ "$COLORTERM" = 24bit ]; then
        # hex color
        export "$(printf "%s" "${var%,*}")"
    else
        # color index
        export "$(printf "%s%s" "${var%\#*}" "${var##*,}")"
    fi
done <<COLORS
SOLARIZED_BASE03=#002B36,8
SOLARIZED_BASE02=#073642,0
SOLARIZED_BASE01=#586E75,10
SOLARIZED_BASE00=#657B83,11
SOLARIZED_BASE0=#839496,12
SOLARIZED_BASE1=#93A1A1,14
SOLARIZED_BASE2=#EEE8D5,7
SOLARIZED_BASE3=#FDF6E3,15
SOLARIZED_YELLOW=#B58900,3
SOLARIZED_ORANGE=#CB4B16,9
SOLARIZED_RED=#DC322F,1
SOLARIZED_MAGENTA=#D33682,5
SOLARIZED_VIOLET=#6C71C4,13
SOLARIZED_BLUE=#268BD2,4
SOLARIZED_CYAN=#2AA198,6
SOLARIZED_GREEN=#859900,2
COLORS

# Local Variables:
# mode: sh
# eval: (rainbow-mode 1)
# End:
