#!/usr/bin/env sh
#
# TODO Don't flicker when changing file

ipc_cmd='{ "command": ["observe_property", 1, "filtered-metadata"] }'
query='select(.data) | .data |
if (.Artist and .Title) then "\(.Artist) ― \(.Title)"
elif .Title then .Title
else "no metadata..." end'

print() {
    if $(echo $1 | jq -r '.event == "end-file"'); then echo ""; fi
    echo $1 | jq -r "$query"
}

# First display
print "$(mpvctl prop filtered-metadata 2>/dev/null)"
# Update the display
echo "$ipc_cmd" | nc -U ~/.mpv.socket | while read -r l ; do print "$l"; done
