# ~/.zprofile
#
# Loaded by login ZSH shells.

# Load =~/.profile= in compatibility mode. By default it's not loaded by
# zsh due to incompatibilites with standard shells.
if [[ $SHLVL == 1 && -o LOGIN ]]; then
    [[ -e ~/.profile ]] && emulate sh -c '. ~/.profile'
fi

# Local Variables:
# mode: sh
# End:
