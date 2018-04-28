include config

if [[ $OS == "macos" ]]; then
    ok cask mpv "${appdir}"
fi
ok directory "${HOME}/.config/mpv"
ok symlink "${HOME}/.config/mpv/input.conf" "${dotfiles}/mpv/input.conf"
ok symlink "${HOME}/.config/mpv/mpv.conf" "${dotfiles}/mpv/mpv.conf"
