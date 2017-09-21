include config

if [[ $OS == "macos" ]]; then
    ok brew gnupg21
    ok brew pinentry-mac
    ok symlink ~/.gnupg/gpg-agent.conf $dotfiles/gpg/gpg-agent.conf
    ok symlink ~/Library/LaunchAgents/bricewge.gpg-agent.plist $dotfiles/gpg/gpg-agent.plist
fi
# TODO chmod diectory
ok directory ~/.gnupg
# Import personal public key
if !gpg2 --list-keys 3D36CAA0116F0F99 >/dev/null 2>&1; then
    gpg2 --import <(curl -L https://clbin.com/HgBmJ)
fi
