#!/usr/bin/env sh
#
# Wrapper around stow. Pass it's argments to stow.

# TODO Do not let still encrypted module to be install
# TODO When uninstalling remove also files from ./setup.sh

set -e

home_hierarchy() {
    (
            cd "$HOME"
            mkdir -p \
                42 \
                download \
                game \
                misc/iso misc/email misc/vpn misc/paperasse \
                misc/model misc/desktop misc/document\
                mnt \
                music \
                org \
                picture/screenshot picture/wallpaper \
                project \
                sharing \
                stream \
                video \
                vm

            mkdir -p \
                "${XDG_CONFIG_HOME}" \
                "${HOME}/.local/src"
    )
}

# apply state specific to me as a user
bricewge() {
    if [ "$USER" != "bricewge" ] && [ "$USER" != "bwaegene" ]; then return; fi

    home_hierarchy
    git -C "$DOTFILES" remote set-url origin \
        git@github.com:bricewge/dotfiles.git
}

# TODO No arguments: install all the packages
if [ $# -eq 0 ]; then
    echo "Use with no arguments is not yet implemented"
    exit 1
fi

# Verify that all the dependencies are installed
dependencies="git stow curl"
for dep in ${dependencies}; do
    command -v "$dep" 1>/dev/null || \
        (printf "dependency '%s' is missing, please install it\n" "$dep" ; \
        exit 1)
done



# TODO Replace $0 because it's unreliable
# https://mywiki.wooledge.org/BashFAQ/028
cd "$(dirname "$0")" || exit 1
DOTFILES=$PWD
export DOTFILES

printf "export DOTFILES=%s" "$DOTFILES" > "$HOME/.shell/profile/dotfiles"

# TODO Source shell env and libs

bricewge

# Arguments: limit the install to those packages
stow "$@"
for pkg in "$@"; do
    if [ -x "$pkg"/setup.sh ]; then (
            cd "$pkg" || exit 1
            # shellcheck disable=SC1091
            . ./setup.sh
            # TODO execute OS subpackages setup
    ) fi
done
