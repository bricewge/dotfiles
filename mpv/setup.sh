#!/usr/bin/env sh
#
# TODO Re-add mpvctl

config_dir=$XDG_CONFIG_HOME/mpv
mkdir -p "$config_dir/scripts"

mpv_thumbnail_dir=$HOME/.local/src/mpv_thumbnail_script
if [ ! -d "$mpv_thumbnail_dir" ]; then
    mkdir -p "$mpv_thumbnail_dir"
    git clone https://github.com/TheAMM/mpv_thumbnail_script.git \
        "$mpv_thumbnail_dir"
fi
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
