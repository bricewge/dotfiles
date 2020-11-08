# ~/.zprofile
#
# Loaded by login ZSH shells.

# Load =~/.profile= in compatibility mode. By default it's not loaded by
# zsh due to incompatibilites with standard shells.
if [[ $SHLVL == 1 && -o LOGIN ]]; then
    [[ -e ~/.profile ]] && emulate sh -c '. ~/.profile'

    # TODO Fix it upstream
    # The special parameters path and PATH are out-of-sync when PATH is set
    # in an sh emulation. Following is a workaroud.
    tmp="$PATH"
    unset PATH
    export PATH="$tmp"
    unset tmp
fi

# Local Variables:
# mode: sh
# End:
