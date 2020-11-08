# ~/.zshenv
#
# First *user* configuration file to be loaded; every invocations of ZSH are
# loading it.

# NOTE This isn't in ~/.zshrc because it is needed to install 'zinit' from
# 'post-stow'.
declare -A ZINIT
ZINIT[HOME_DIR]="$HOME/.zsh/zinit"
ZINIT[BIN_DIR]="$ZINIT[HOME_DIR]/bin" # zinit's git repository
ZPFX="$ZINIT[HOME_DIR]/local"

# Local Variables:
# mode: sh
# End:
