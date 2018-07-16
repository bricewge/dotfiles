include config

ok directory "${HOME}/.config/autorandr/docked"
ok directory "${HOME}/.config/autorandr/postswitch.d"

ok symlink "${HOME}/.config/autorandr/docked/postswitch" "${dotfiles}/autorandr/docked/postswitch"
ok symlink "${HOME}/.config/autorandr/postswitch.d/polybars.sh" "${dotfiles}/bin/polybars.sh"
ok symlink "${HOME}/.config/autorandr/settings.ini" "${dotfiles}/autorandr/settings.ini"
