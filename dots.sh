#!/usr/bin/env sh
#
# Wrapper around stow.

set -e

# TODO No arguments: install all the packages
if [ $# -eq 0 ]; then
    echo "Use with no arguments is not yet implemented"
    exit 1
fi

cd "$(dirname "$0")" || exit 1

# Arguments: limit the install to those packages
stow --target "$HOME" "$@"
for pkg in "$@"; do
    if [ -x "$pkg"/setup.sh ]; then (
            cd "$pkg" || exit 1
            ./setup.sh
    ) fi
done
