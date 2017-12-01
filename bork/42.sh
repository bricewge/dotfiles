include config

if [[ ! $(hostname | cut -d . -f 2-3) == "42.fr" ]]; then
    exit
fi
ok directory "/sgoinfre/goinfre/Perso/${USER}"
chmod 700 "/sgoinfre/goinfre/Perso/${USER}"
ok symlink "${HOME}/sgoinfre" "/sgoinfre/goinfre/Perso/${USER}"
ok symlink "${HOME}/goinfre" "/Volumes/Storage/goinfre/${USER}"
ok symlink "${HOME}/VirtualBox VMs" "${HOME}/sgoinfre/VirtualBox VMs"
ok symlink "${HOME}/.docker" "${USER}/sgoinfre/docker"

source "${dotfiles}/env/profile"
source "${dotfiles}/zsh/zshrc"
ok git "${HOME}/.brew" https://github.com/Homebrew/brew.git

