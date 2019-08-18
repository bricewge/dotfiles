# * rofi
theme=$(readlink "$XDG_CONFIG_HOME/rofi/config")
if [ ! "$(dirname "$theme")" =  "$XDG_CONFIG_HOME/rofi" ]; then
    symlink "$XDG_CONFIG_HOME/rofi/solarized-dark" \
        "$XDG_CONFIG_HOME/rofi/config"
fi

# * rofi calc
repository https://github.com/onespaceman/menu-calc.git \
    "$HOME/.local/src/menu-calc"
symlink "$HOME/.local/src/menu-calc/=" "$HOME/.local/bin/="

# * rofi wifi
# WAITING https://github.com/zbaylin/rofi-wifi-menu/pull/15
# git clone https://github.com/zbaylin/rofi-wifi-menu.git \
    repository https://github.com/bricewge/rofi-wifi-menu.git \
"${HOME}/.local/src/rofi-wifi-menu"
symlink "$HOME/.local/src/rofi-menu-wifi/rofi-menu-wifi.sh" \
    "$HOME/.local/bin/rofi-wifi"

# * rofi power
rofi_power_dir="$HOME/.local/src/rofi-tools"
repository https://github.com/okraits/rofi-tools.git \
        "$rofi_power_dir"
symlink "$rofi_power_dir/rofi-power" "$HOME/.local/bin/rofi-power"

# * udiskie dmenu
repository https://github.com/fogine/udiskie-dmenu.git \
    "$HOME/.local/src/udiskie-dmenu"
symlink "$HOME/.local/src/udiskie-dmenu/udiskie-dmenu" \
    "$HOME/.local/bin/udiskie-dmenu"
