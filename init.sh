#!/bin/sh

set -e

user=$(whoami)
home=$HOME
fileroot=$(pwd)
decrypted=False

if file "$fileroot/ssh/init.sls" | grep -q text$; then
    decrypted=True
fi

echo "Running as '$user' with home directory '$home'..."

# Apply the dotfiles to your home
sudo salt-call                                      \
     --log-level warning                            \
     --state-output changes                         \
     --file-root  "$fileroot"                       \
     --local                                        \
     state.highstate                                \
     pillar="{'dotfiles':                           \
                        {'user': '$user',           \
                         'home': '$home',           \
                         'fileroot': '$fileroot',   \
                         'decrypted': '$decrypted'} \
            }"


