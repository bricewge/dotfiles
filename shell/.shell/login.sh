# Sourced by all login shells.

# source files to be loaded by login shells
login_dir=${HOME}/.shell/login.d/
if [ -d "$login_dir" ]; then
    for file in "$login_dir"/*.sh; do
        # shellcheck source=/dev/null
        . "$file"
    done
fi
