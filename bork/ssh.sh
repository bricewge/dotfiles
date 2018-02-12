include config

ok directory ~/.ssh --mode=700
ok directory ~/.ssh/socket
ok symlink ~/.ssh/known_hosts "${dotfiles}/ssh/known_hosts"
ok symlink ~/.ssh/config "${dotfiles}/ssh/config"
