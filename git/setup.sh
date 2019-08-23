#!/usr/bin/env sh

set -e

+# shellcheck disable=SC1090
+. "${DOTFILES:-.}/shell/.shell/lib/utils.sh"

git_fire_dir="$HOME/.local/src/git-fire"
if [ ! -d "$git_fire_dir" ]; then
    mkdir -p "$git_fire_dir"
    git clone https://github.com/qw3rtman/git-fire.git "$git_fire_dir"
    ln -s "$HOME/.local/bin/git-fire" "$git_fire_dir"
fi

# WAITING https://github.com/aspiers/stow/issues/3
template_dir=$HOME/.config/git/template
if [ ! -d "$template_dir" ]; then
    ln -s "$PWD/_template" "$template_dir"
fi
