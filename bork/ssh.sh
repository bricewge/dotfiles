include config

if ok directory ~/.ssh; then
    chmod 700 ~/.ssh
fi
ok directory ~/.ssh/socket
ok symlink ~/.ssh/known_hosts "${dotfiles}/ssh/known_hosts"
ok symlink ~/.ssh/config "${dotfiles}/ssh/config"
