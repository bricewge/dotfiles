#!/usr/bin/env sh

# Since hombrew maintainers won't set pinentry-mac as default, let's get dirty!
# https://github.com/Homebrew/homebrew-core/issues/18011
ln -s "${HOME}/.brew/bin/pinentry-mac" "${HOME}/.local/bin/pinentry"

# initialze gpg-agent service
launchctl load "${HOME}/Library/LaunchAgents/fr.bricewge.gpg-agent.plist"
launchctl start fr.bricewge.gpg-agent
