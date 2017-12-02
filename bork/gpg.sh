include config

if ok directory ~/.gnupg; then
    chmod 700 ~/.gnupg
fi
if [[ $OS == "macos" ]]; then
    ok brew gnupg
    ok brew pinentry-mac
    # Since hombrew maintainers won't set pinentry-mac as default, let's get dirty!
    # https://github.com/Homebrew/homebrew-core/issues/18011
    cp -f "${dotfiles}/gpg/gpg-agent.conf" "${HOME}/.gnupg/" && \
        echo "pinentry-program /Users/bwaegene/.brew/bin/pinentry-mac" >> "${HOME}/.gnupg/gpg-agent.conf"
    ok symlink ~/Library/LaunchAgents/bricewge.gpg-agent.plist "${dotfiles}/gpg/gpg-agent.plist"
	  launchctl load ~/.dotfiles/gpg/gpg-agent.plist
	  launchctl start bricewge.gpg-agent
else
    ok symlink ~/.gnupg/gpg-agent.conf "${dotfiles}/gpg/gpg-agent.conf"
fi
# Import personal public key
if ! gpg --list-keys 3D36CAA0116F0F99 >/dev/null 2>&1; then
    curl -sSL https://clbin.com/HgBmJ | gpg --import -
fi
