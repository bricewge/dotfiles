include config

ok symlink "${HOME}/.xinitrc" "${dotfiles}/bspwm/xinitrc"
ok symlink "${HOME}/.Xresources" "${dotfiles}/bspwm/Xresources"
ok symlink "${HOME}/.xsession" "${dotfiles}/bspwm/xsession"

ok symlink "${HOME}/.config/compton.conf" "${dotfiles}/bspwm/compton.conf"

ok symlink "${HOME}/.config/polybar" "${dotfiles}/polybar"

ok directory "${HOME}/.config/mimeo"
ok symlink "${HOME}/.config/mimeo/associations.txt" "${dotfiles}/bspwm/mimeo.conf"

ok directory "${HOME}/.config/bspwm"
ok symlink "${HOME}/.config/bspwm/bspwmrc" "${dotfiles}/bspwm/bspwmrc"
ok symlink "${HOME}/.config/bspwm/env" "${dotfiles}/bspwm/env"
ok directory "${HOME}/.config/sxhkd"
ok symlink "${HOME}/.config/sxhkd/sxhkdrc" "${dotfiles}/bspwm/sxhkdrc"
