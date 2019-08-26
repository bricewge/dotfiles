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

repository() {
    repo=$1
    destination=$2
    branch=${3:-master}

    mkdir -p "$destination"
    (
        cd "$destination" || exit 1
        printf "%s: %s at %s\n" "$destination" "$repo" "$branch"
        if git rev-parse --is-inside-work-tree > /dev/null 2>&1 ; then
            git pull
            git checkout "$branch"
        else
            git clone "$repo" "$destination" --branch "$branch"
        fi
    )
}

user_is_me() {
    case "$(whoami)" in
        bricewge|bwaegene)
            return 0
            ;;
    esac
    return 1
}
