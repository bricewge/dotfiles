# ~/.zshenv
#
# The first *user* config to be loaded; every invocations of ZSH are
# loading it.

# Load =~/.profile= in compatibility mode. By default it's not loaded
# by zsh due to incompatibilites with standard shells.
if [[ $SHLVL == 1 && ! -o LOGIN ]]; then
    [[ -e ~/.profile ]] && emulate sh -c '. ~/.profile'
fi

if [[ -o INTERACTIVE ]]; then
    emulate sh -c '. ~/.shell/interactive.sh'
fi

# NOTE This isn't in ~/.zshrc because it is needed to install 'zinit' from
# 'post-stow'.
declare -A ZINIT
ZINIT[HOME_DIR]="$HOME/.zsh"
ZINIT[BIN_DIR]="$ZINIT[HOME_DIR]/zinit" # zinit's git repository

# Local Variables:
# mode: sh
# End:
