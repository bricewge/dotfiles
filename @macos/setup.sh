#!/usr/bin/env sh

# TODO install brew
# git clone https://github.com/Homebrew/brew.git "${HOME}/.brew"

# Display ~/Library
chflags nohidden ~/Library/

# * 42born2code
if [ "$(hostname | cut -d . -f 2-3)" != "42.fr" ]; then exit; fi

mkdir -p "/sgoinfre/goinfre/Perso/${USER}"
chmod 700 "/sgoinfre/goinfre/Perso/${USER}"
if [ ! -L "${HOME}/sgoinfre" ]; then
    ln -s "/sgoinfre/goinfre/Perso/${USER}" "${HOME}/sgoinfre"
fi

mkdir -p "/Volumes/Storage/goinfre/${USER}"
chmod 700 "/Volumes/Storage/goinfre/${USER}"
if [ ! -L "${HOME}/goinfre" ]; then
    ln -s "/Volumes/Storage/goinfre/${USER}" "${HOME}/goinfre"
fi

ok symlink "${HOME}/VirtualBox VMs" "${HOME}/sgoinfre/VirtualBox VMs"
ok symlink "${HOME}/.docker" "${HOME}/sgoinfre/docker"

# fix home
launchctl load "${DOTFILES}/misc/42home-fix.plist"
launchctl start bricewge.42home-fix

# Disable PIV popup https://support.yubico.com/support/solutions/articles/15000006468
sc_auth pairing_ui -s disable

# TODO macOS setup
# - time
# - bluetooth
# - keyboard
# - mouse
# - security
# - wifi

# TODO iTerm
