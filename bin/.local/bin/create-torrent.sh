#!/usr/bin/env bash
#
# Create a torrent remotly.
# example: ./create-torrent.sh bob@myhost:/mnt/data ~/download/Sintel/

# TODO Find a way to specify ssh port
# TODO Call pass only once
# TODO ssh port forwarding shouldn't be hard coded

set -e

[ $# -eq 0 ] && { echo "usage: $0 host:dest src [src...]" >&2; exit 1; }

destination=$1
shift

# redirect deluge's control port locally
remote=${destination%:*}
ssh -fNT -L 127.0.0.2:58846:192.168.1.10:58846 "$remote"
die() {
    # FIXME doesn't seems to work
    ssh -O cancel 127.0.0.2:58846:192.168.1.10:58846 "$remote"
}
trap die ERR

# get deluge credentials
deluge_login=$(pass selfhosted/torrent | awk '/login/ {print $2}')
deluge_password=$(pass selfhosted/torrent | head -n1)

for source in "$@"; do
    source=./${source%/}

    # generate a torrent file
    torrent=${source}.torrent
    webtorrent create "$source" > "$torrent"

    # send the torrent file and it's data to the server
    rsync --human-readable --progress \
        --recursive --update  \
        "$source" "$destination"

    # add torrent to deluge
    deluge-console "connect 127.0.0.2:58846 '$deluge_login' '$deluge_password' ; add \"$torrent\""
done
