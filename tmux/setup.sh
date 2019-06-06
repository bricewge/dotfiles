plugins_dir=$HOME/.tmux/plugins
mkdir -p "$plugins_dir"

if ! [ -d "$plugins_dir/tpm" ]; then
    # WAITING https://github.com/tmux-plugins/tpm/pull/158
    # git clone https://github.com/tmux-plugins/tpm.git "$plugins_dir/tpm"
    git clone --branch add-branch-to-plugin \
        https://github.com/rafalrothenberger/tpm.git \
        "$plugins_dir/tpm"
    "$$plugins_dir/tpm/bin/install_plugins"
fi
