# Loaded by every zsh shell Do not put environement variables in it, use
# ~/.profile for it.

# * zplugin
if [ "$TERM" != 'dumb' ]; then
    source "$HOME/.zsh/zpluginrc"
fi

# * zsh config
# ** environment
# *** Smart URLs
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# *** General
setopt BRACE_CCL          # Allow brace character class list expansion.
setopt COMBINING_CHARS    # Combine zero-length punctuation characters (accents)
# with the base character.
setopt RC_QUOTES          # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
unsetopt MAIL_WARNING     # Don't print a warning message if a mail file has been accessed.
setopt CHASE_LINKS        # Always use abolute path when cd with a symlink

# *** Jobs
setopt LONG_LIST_JOBS     # List jobs in the long format by default.
setopt AUTO_RESUME        # Attempt to resume existing job before creating a new process.
setopt NOTIFY             # Report status of background jobs immediately.
unsetopt BG_NICE          # Don't run all background jobs at a lower priority.
unsetopt HUP              # Don't kill jobs on shell exit.
unsetopt CHECK_JOBS       # Don't report on jobs when shell exit.

# *** direnv
eval "$(direnv hook zsh)"

# ** history
export HISTSIZE=10000           # The maximum number of events to save in the internal history.
export SAVEHIST=10000           # The maximum number of events to save in the history file.

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing non-existent history.

# ** emacs key bindings
bindkey -e

# * completion
# Enable completion
# autoload -Uz compinit
# compinit
# Use menu for choising correct completion
zstyle ':completion:*' menu select
# Enable completion for new installed command within the session by
# not trust the zsh's cache of executable command, and forced it be
zstyle ":completion:*:commands" rehash 1

# * alias
# ** sudo
# Pass alias to sudo and prevent =nocorrect= errors
# https://superuser.com/a/749333
alias sudo='my_sudo '

function my_sudo {
    while [[ $# > 0 ]]; do
        case "$1" in
            command) shift ; break ;;
            nocorrect|noglob) shift ;;
            *) break ;;
        esac
    done
    if [[ $# = 0 ]]; then
        command sudo zsh
    else
        noglob command sudo $@
    fi
}


# ** rm
# Force the use of trash instead of rm
alias rm='echo -e "You are looking for *th*, not rm.
If you want to delete a file FOREVER use \\\rm."; false'
alias th='trash'

# ** misc
alias yt="youtube-dl"
alias ff="firefox"
alias feh="feh --scale-down --auto-zoom -B black -g ''"
alias to="webtorrent"
alias diff="diff --color -u"

# ** linux
# *** ip
# Colorize the output of iproute2
if [[ $OS != "debian" ]]; then
    alias ip='ip -c'
fi

# Display only IPv4 or IPv6
alias ip4="ip -4"
alias ip6="ip -6"

# *** systemd
alias sc="systemctl"
alias jc="journalctl"

# Local Variables:
# mode: sh
# sh-shell: zsh
# End:
