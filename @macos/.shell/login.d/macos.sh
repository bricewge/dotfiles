export PATH=$HOME/.brew/bin:$PATH

if [ "$(uname -n | cut -d . -f 2-3)" = "42.fr" ]; then
    export HOMEBREW_CASK_OPTS='--appdir=~/Applications'
    # Disable constant logging of the terminal
    unset -f precmd
fi
