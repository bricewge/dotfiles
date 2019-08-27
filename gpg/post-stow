#!/bin/sh

# shellcheck disable=SC1090
. "${DOTFILES:-.}/shell/.shell/lib/utils.sh"

keyid="3D36CAA0116F0F99"
keyurl="https://github.com/bricewge.gpg"

# TODO Import trust with --import-ownertrust https://gist.github.com/chrisroos/1205934
# TODO Import from keyserver

# import and trust personal public key
if ! gpg --list-keys "$keyid" >/dev/null 2>&1; then
    curl -sSL "$keyurl" | gpg --import -
    printf 'trust\n5\ny\n\n' | gpg --command-fd 0 --edit-key "$keyid"
    if systemctl --user --quiet is-active gpg-agents.service; then
        systemctl --user restart gpg-agent.service
    fi
fi
