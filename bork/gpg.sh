dotfiles="$HOME/.dotfiles"

ok brew-tap homebrew/versions
ok brew gnupg21
ok brew pinentry-mac
# import key
gpg2 --import <(curl -L https://clbin.com/HgBmJ)
# TODO chmod diectory
ok directory ~/.gnupg
ok symlink ~/.gnupg/gpg-agent.conf $dotfiles/gpg/gpg-agent.conf
ok symlink ~/Library/LaunchAgents/bricewge.gpg-agent.plist $dotfiles/gpg/gpg-agent.plist
