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
    branch=${3:-master}

    printf "%s: %s at %s\n" "$destination" "$repo" "$branch"
    if [ -e "$destination" ] && \
        git -C "$destination" rev-parse --is-inside-work-tree \
        2>/dev/null 1>/dev/null; then
        git -C "$destination" pull
        git -C "$destination" checkout "$branch"
    else
        mkdir -p "$(dirname "$destination")"
        git clone "$repo" --branch "$branch"
    fi
}
