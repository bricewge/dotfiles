#!//bin/sh

# shellcheck disable=SC1090
. "${DOTFILES:-.}/shell/.shell/lib/utils.sh"

config_dir=$(bat --config-dir)

# * themes
mkdir -p "$config_dir/themes"
# WAITING https://github.com/sharkdp/bat/issues/339
# git clone https://github.com/paulcpederson/solarized-sublime.git \
repository https://github.com/bricewge/solarized-sublime.git \
  "$config_dir/themes/solarized"

# * syntaxes
# WAITING For release of bat > 0.11.0
mkdir -p "$config_dir/syntaxes"
repository https://gist.github.com/25edc5f66404dee2fe19bf90c205a29c.git \
  "$config_dir/syntaxes/org-mode"

bat cache --build
