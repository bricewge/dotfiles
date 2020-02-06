# Executed by all login shells. Only environement variables should goes in here.

test -e /etc/profile && . /etc/profile

# shellcheck source=/dev/null
. "$HOME/.shell/environment"

# shellcheck source=/dev/null
. "$HOME/.shell/login.sh"


# Local Variables:
# mode: sh
# sh-shell: sh
# End:
