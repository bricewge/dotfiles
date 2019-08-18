#!/bin/sh

symlink() {
    target=$1
    destination=$2

    printf "%s -> %s\n" "$destination" "$target"
    if [ "$(readlink "$target")" = "$destination" ]; then
        return;
    else
        if [ -e "$destination"  ]; then
            mv "$destination" "${destination}.bak"
        fi
    fi

    mkdir -p "$(dirname "$destination")"
    ln -sbf "$target" "$destination"
}

repository() {
    repo=$1
    destination=$2
    shift; shift

    printf "%s: %s\n" "$destination" "$repo"
    if [ -e "$destination" ] && \
        git -C "$destination" rev-parse --is-inside-work-tree \
        2>/dev/null 1>/dev/null; then
        git -C "$destination" pull
    else
        mkdir -p "$(dirname "$destination")"
        git clone "$repo" $@
    fi
}
