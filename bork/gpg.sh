include config

if ok directory ~/.gnupg; then
    chmod 700 ~/.gnupg
fi
ok symlink ~/.gnupg/gpg-agent.conf "${dotfiles}/gpg/gpg-agent.conf"
if [[ $OS == "macos" ]]; then
    ok brew gnupg
    ok brew pinentry-mac
    ok symlink ~/Library/LaunchAgents/bricewge.gpg-agent.plist "${dotfiles}/gpg/gpg-agent.plist"
fi
# Import personal public key
if !gpg2 --list-keys 3D36CAA0116F0F99 >/dev/null 2>&1; then
    gpg2 --import <$(curl -L https://clbin.com/HgBmJ)
fi
