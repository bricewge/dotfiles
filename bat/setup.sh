#!/usr/bin/env sh

config_dir=$(bat --config-dir)
mkdir -p "$config_dir/{syntaxes,themes}"

# * themes
git clone https://github.com/paulcpederson/solarized-sublime.git \
  "$config_dir/themes/solarized"

bat cache --build
