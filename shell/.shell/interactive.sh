# Sourced by all interactive shells.

# source files to be loaded by interactive shells
interactive_dir=${HOME}/.shell/interactive.d/
if [ -d "$interactive_dir" ]; then
    for file in "$interactive_dir"/*.sh; do
        # shellcheck source=/dev/null
        . "$file"
    done
fi
