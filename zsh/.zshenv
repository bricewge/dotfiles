# Load =~/.profile= in compatibility mode. By default it's not loaded
# by zsh due to incompatibilites with standard shells.
if [[ $SHLVL == 1 && ! -o LOGIN ]]; then
    [[ -e ~/.profile ]] && emulate sh -c '. ~/.profile'
fi

if [[ -o INTERACTIVE ]]; then
    emulate sh -c '. ~/.shell/interactive.sh'
fi

# zplugin
declare -A ZPLGM
ZPLGM[HOME_DIR]=$HOME/.zsh/zplugin
ZPLGM[BIN_DIR]=$ZPLGM[HOME_DIR]/bin

# Local Variables:
# mode: sh
# End:
