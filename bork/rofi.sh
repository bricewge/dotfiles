include config

ok directory ~/.config/rofi-pass
ok symlink ~/.config/rofi-pass/config "${dotfiles}/rofi/rofi-pass.conf"

ok github ~/.local/src/menu-calc onespaceman/menu-calc
ok symlink ~/.local/bin/= ~/.local/src/menu-calc/=

ok github ~/.local/src/rofi-wifi-menu zbaylin/rofi-wifi-menu
ok symlink ~/.local/bin/rofi-wifi ~/.local/src/rofi-wifi-menu/rofi-wifi-menu.sh
ok directory ~/.config/rofi-wifi
ok symlink ~/.config/rofi-wifi/config "${dotfiles}/rofi/rofi-wifi.conf"

# * WAIT https://github.com/okraits/rofi-tools/pull/3 to be merged
ok github ~/.local/src/rofi-tools bricewge/rofi-tools
ok symlink ~/.local/bin/rofi-power ~/.local/src/rofi-tools/rofi-power
ok directory ~/.config/rofi-power
ok symlink ~/.config/rofi-power/config "${dotfiles}/rofi/rofi-power.conf"

ok github ~/.local/src/rofi-scripts carnager/rofi-scripts
