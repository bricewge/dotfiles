# * rofi calc
if ! [ -d "${HOME}/.local/src/menu-calc" ]; then
    git clone https://github.com/onespaceman/menu-calc.git \
        "${HOME}/.local/src/menu-calc"
    ln -s "${HOME}/.local/src/menu-calc/=" "${HOME}/.local/bin/="
fi

# * rofi wifi
if ! [ -d "${HOME}/.local/src/rofi-wifi-menu" ]; then
    # WAITING https://github.com/zbaylin/rofi-wifi-menu/pull/15
    # git clone https://github.com/zbaylin/rofi-wifi-menu.git \
    git clone https://github.com/bricewge/rofi-wifi-menu.git \
        "${HOME}/.local/src/rofi-wifi-menu"
    ln -s "${HOME}/.local/src/rofi-menu-wifi/rofi-menu-wifi.sh" \
        "${HOME}/.local/bin/rofi-wifi"
fi

# * rofi power
if ! [ -d "${HOME}/.local/src/rofi-tools" ]; then
    git clone https://github.com/okraits/rofi-tools.git \
        "${HOME}/.local/src/rofi-tools"
    ln -s "${HOME}/.local/src/rofi-tools/rofi-power" \
        "${HOME}/.local/bin/rofi-power"
fi

# * udiskie dmenu
if [ ! -d "$HOME/.local/src/udiskie-dmenu" ]; then
    git clone https://github.com/fogine/udiskie-dmenu.git \
        "$HOME/.local/src/udiskie-dmenu"
    ln -s "$HOME/.local/src/udiskie-dmenu/udiskie-dmenu" \
        "${HOME}/.local/bin/udiskie-dmenu"
fi
