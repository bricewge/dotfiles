include config

ok directory "${HOME}/.config/rofi"
ok symlink "${HOME}/.config/rofi/config" "${dotfiles}/rofi/config"

ok directory ~/.config/rofi-pass
ok symlink ~/.config/rofi-pass/config "${dotfiles}/rofi/rofi-pass.conf"

ok github ~/.local/src/menu-calc onespaceman/menu-calc
ok symlink ~/.local/bin/= ~/.local/src/menu-calc/=

ok github ~/.local/src/rofi-wifi-menu zbaylin/rofi-wifi-menu
ok symlink ~/.local/bin/rofi-wifi ~/.local/src/rofi-wifi-menu/rofi-wifi-menu.sh
ok directory ~/.config/rofi-wifi
ok symlink ~/.config/rofi-wifi/config "${dotfiles}/rofi/rofi-wifi.conf"

ok github ~/.local/src/rofi-tools okraits/rofi-tools
ok symlink ~/.local/bin/rofi-power ~/.local/src/rofi-tools/rofi-power
ok directory ~/.config/rofi-power
ok symlink ~/.config/rofi-power/config "${dotfiles}/rofi/rofi-power.conf"

ok github ~/.local/src/rofi-scripts carnager/rofi-scripts


ok github ~/.local/src/udiskie-dmenu fogine/udiskie-dmenu
ok symlink "${HOME}/.local/bin/udiskie-dmenu" \
   "${HOME}/.local/src/udiskie-dmenu/udiskie-dmenu"
