#!/usr/bin/env sh

# TODO Make it works with multiple monitors
# - Create a "server" which make unix socket with =netcat= or =socat=
# - Listeners read on the unix socket

[ $# -ne 1 ] && exit 1

status_fifo=$1

icon=""
text_color="#586e75"
normal_color="#93a1a1"
chain_color="#b58900"

color=${normal_color}

echo "%{B${color} F${text_color}} ${icon} %{B- F-}"

exec 3< "$status_fifo"
while read -r line <&3; do
    case "$line" in
        B*) color="${chain_color}" ;;
        E*) color="${normal_color}" ;;
    esac
    echo "%{B${color} F${text_color}} ${icon} %{B- F-}"
done
exec 3<&-

# Local Variables:
# eval: (rainbow-mode)
# End:
