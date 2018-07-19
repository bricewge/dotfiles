include config

ok directory "${HOME}/.config/alacritty"
ok symlink "${HOME}/.config/alacritty/alacritty.yml" "${dotfiles}/alacritty/alacritty.yml"
ok directory "${HOME}/.terminfo/x/"
ok symlink "${HOME}/.terminfo/x/xterm-24bit" "${dotfiles}/alacritty/xterm-24bit"
