include config

if [[ ! $(hostname | cut -d . -f 2-3) == "42.fr" ]]; then
    exit
fi
ok directory "/sgoinfre/goinfre/Perso/${USER}"
chmod 700 "/sgoinfre/goinfre/Perso/${USER}"
ok symlink "${HOME}/sgoinfre" "/sgoinfre/goinfre/Perso/${USER}"
ok directory "/Volumes/Storage/goinfre/${USER}"
chmod 700 "/Volumes/Storage/goinfre/${USER}"
ok symlink "${HOME}/goinfre" "/Volumes/Storage/goinfre/${USER}"
ok symlink "${HOME}/VirtualBox VMs" "${HOME}/sgoinfre/VirtualBox VMs"
ok symlink "${HOME}/.docker" "${HOME}/sgoinfre/docker"

source "${dotfiles}/env/profile"
# source "${dotfiles}/zsh/zshrc"
ok git "${HOME}/.brew" https://github.com/Homebrew/brew.git

ok brew python3
ok symlink "${HOME}/Library/LaunchAgents/bricewge.42home-fix.plist" \
   "${dotfiles}/misc/42home-fix.plist"
launchctl load ~/.dotfiles/misc/42home-fix.plist
launchctl start bricewge.42home-fix

# * macOS
# ** Finder
# Display ~/Library
chflags nohidden ~/Library/

# TODO macOS setup
# - time
# - bluetooth
# - keyboard
# - mouse
# - security
# - wifi

# TODO iTerm
