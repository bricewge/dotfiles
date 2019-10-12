#!/usr/bin/env sh
#
# TODO Don't flicker when changing file

mpv_socket=$(awk -F= '/input-ipc-server/ {print $2}'  ~/.config/mpv/mpv.conf)
ipc_cmd='{ "command": ["observe_property", 1, "filtered-metadata"] }'
query='select(.data) | .data |
if (.Artist and .Title) then "\(.Artist) ― \(.Title)"
elif .Title then .Title
else "no metadata..." end'

print() {
    if $(echo $1 | jq -r '.event == "end-file"'); then echo ""; fi
    echo $1 | jq -r "$query"
}

echo "$ipc_cmd" | nc -U "$mpv_socket" | while read -r l ; do print "$l"; done
