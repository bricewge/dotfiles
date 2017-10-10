include config

ok directory ~/.config
ok symlink ~/.config/redshift.conf "${dotfiles}/redshift/redshift.conf"
if [[ $OS == "macos" ]]; then
    ok brew redshift
    if [[ ! -e ~/Library/LaunchAgents/homebrew.mxcl.redshift.plist ]]; then
       brew services start redshift
    fi
fi
