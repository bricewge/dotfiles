#!/usr/bin/env sh
#
# Wrapper around stow. Pass it's argments to stow.

# TODO Verify that the dependencies are installed
# TODO Do not let still encrypted module to be install
# TODO When uninstalling remove also files from ./setup.sh

set -e

# TODO No arguments: install all the packages
if [ $# -eq 0 ]; then
    echo "Use with no arguments is not yet implemented"
    exit 1
fi

cd "$(dirname "$0")" || exit 1
DOTFILES=$PWD
export DOTFILES

printf "export DOTFILES=%s" "$DOTFILES" > "$HOME/.shell/profile/dotfiles"

# TODO Source shell env and libs

# Arguments: limit the install to those packages
stow --target "$HOME" "$@"
for pkg in "$@"; do
    if [ -x "$pkg"/setup.sh ]; then (
            cd "$pkg" || exit 1
            # shellcheck disable=SC1091
            . ./setup.sh
            # TODO execute OS subpacakges setup
    ) fi
done
