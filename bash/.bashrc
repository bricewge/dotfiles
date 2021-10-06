# ~/.bash_profile
#
# Loaded by all interactive Bash shells.
#
# By default it's only done for interactive non-login Bash shells but we
# force interactive login Bash shells to load it too from ~/.bash_profile
# to be more consitent between different shells (POSIX and ZSH).

if [ -f ~/.shell/interactive.sh ]; then
    . ~/.shell/interactive.sh
fi

# Local Variables:
# sh-shell: bash
# End:
