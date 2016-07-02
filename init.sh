#!/bin/sh

set -e

user=$(id -un)
uid=$(id -u)
group=$(id -gn)
home=$HOME
fileroot=$(pwd)
decrypted=False

if file "$fileroot/ssh/init.sls" | grep -q text$; then
    decrypted=True
fi

echo -e "Running as '\033[1m$user\033[0m' with home directory '\033[1m$home\033[0m'..."

# Apply the dotfiles to your home
sudo salt-call                                       \
     --log-level warning                             \
     --state-output changes                          \
     --file-root  "$fileroot"                        \
     --local                                         \
     state.highstate                                 \
     pillar="{'dotfiles':                            \
                        {'user': '$user',            \
                         'uid': '$uid',              \
                         'group': '$group',          \
                         'home': '$home',            \
                         'fileroot': '$fileroot',    \
                         'decrypted': '$decrypted'}, \
            }"
