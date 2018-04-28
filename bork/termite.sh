include config

ok directory "${HOME}/.config/termite"
ok symlink "${HOME}/.config/termite/dark" "${dotfiles}/termite/dark"
ok symlink "${HOME}/.config/termite/light" "${dotfiles}/termite/light"
ok symlink "${HOME}/.config/termite/config" "${HOME}/.config/termite/dark"
