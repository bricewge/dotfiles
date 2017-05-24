dotfiles="$HOME/.dotfiles"

if [[ $OS == "macos" ]]; then
    ok brew gnupg21
    ok brew pinentry-mac
    ok symlink ~/.gnupg/gpg-agent.conf $dotfiles/gpg/gpg-agent.conf
    ok symlink ~/Library/LaunchAgents/bricewge.gpg-agent.plist $dotfiles/gpg/gpg-agent.plist
fi
# TODO chmod diectory
ok directory ~/.gnupg
# import personal public key
gpg2 --import <(curl -L https://clbin.com/HgBmJ)
