#!/usr/bin/env sh
#
# Listen on sxhkd events to:
# - indicate when in a chord chain

SXHKD_FIFO=${SXHKD_FIFO:-${HOME}/.sxhkd.fifo}

exec 3< "${SXHKD_FIFO}"
while read -r line <&3; do
    case "$line" in
        B*) hook=2 ;;
        E*) hook=1 ;;
    esac
    polybar-msg hook sxhkd "${hook}"
done
exec 3<&-
