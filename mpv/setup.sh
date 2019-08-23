#!/usr/bin/env sh
#
# TODO Re-add mpvctl

# shellcheck disable=SC1090
. "${DOTFILES:-.}/shell/.shell/lib/utils.sh"

config_dir=$XDG_CONFIG_HOME/mpv
mkdir -p "$config_dir/scripts"

mpv_thumbnail_dir=$HOME/.local/src/mpv_thumbnail_script
repository https://github.com/TheAMM/mpv_thumbnail_script.git \
    "$mpv_thumbnail_dir"
# Upstream generate those files with python and make. Let's do the same the UNIX
# way, with our trusty cat.
(
    cd "$mpv_thumbnail_dir" || exit 1
    cat "lib/helpers.lua" "lib/sha1.lua" "src/options.lua" \
        "src/thumbnailer_shared.lua" "src/patched_osc.lua" \
        > "$config_dir/scripts/mpv_thumbnail_script_client_osc.lua"
    cat "lib/helpers.lua" "src/options.lua" "src/thumbnailer_server.lua" \
        > "$config_dir/scripts/mpv_thumbnail_script_server.lua"
)
