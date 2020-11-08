# Create a symbolic link and it's parent directories.
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
    ln --suffix=.bak -sbf "$target" "$destination"
}

# Keep a git repository up-to-date by cloning or pulling it.
repository() {
    repo=$1
    destination=$2
    branch=${3:-master}

    mkdir -p "$destination"
    (
        cd "$destination" || exit 1
        printf "%s: %s at %s\n" "$destination" "$repo" "$branch"
        if git rev-parse --is-inside-work-tree > /dev/null 2>&1 ; then
            git fetch --all --tags
            git checkout "$branch"
        else
            git clone "$repo" "$destination"
            git switch --track --create "$branch"
        fi
    )
}

# Generate a theme file from a template - in place. The generated file will be
# in the same directory without the .m4 extension.
theme_template() {
    template=$1 # assumed to be /path/file.m4

    output=${template%*.m4}

    theme_variant=$(readlink -f "$XDG_CONFIG_HOME/theme/current-theme")
    theme_base=$(dirname "$theme_variant")/base.m4
    m4 "$theme_base" "$theme_variant" "$template" \
        > "$output"
}

# Return true if the user is Brice Waegeneire.
user_is_me() {
    case "$(whoami)" in
        bricewge|bwaegene)
            return 0
            ;;
    esac
    return 1
}
