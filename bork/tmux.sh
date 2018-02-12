include config

ok directory "${HOME}/.tmux/plugins"
ok github "${HOME}/.tmux/plugins/tpm" tmux-plugins/tpm
ok symlink "${HOME}/.tmux.conf" "${dotfiles}/tmux/config"
