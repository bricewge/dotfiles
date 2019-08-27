#!/bin/sh

set -e

# shellcheck disable=SC1090
. "${DOTFILES:-.}/shell/.shell/lib/utils.sh"

git_fire_dir="$HOME/.local/src/git-fire"
repository https://github.com/qw3rtman/git-fire.git "$git_fire_dir"
symlink "$git_fire_dir/git-fire" "$HOME/.local/bin/git-fire"

# WAITING https://github.com/aspiers/stow/issues/3
symlink "$PWD/_template" "$HOME/.config/git/template"
