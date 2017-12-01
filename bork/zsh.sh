include config

if [[ $OS == "macos" ]]; then
    ok brew-tap homebrew/command-not-found
    ok brew terminal-notifier
fi
ok symlink ~/.zshrc "${dotfiles}/zsh/zshrc"
ok symlink ~/.zshenv "${dotfiles}/zsh/zshenv"
ok symlink ~/.zpreztorc "${dotfiles}/zsh/zpreztorc"
ok symlink ~/.zprofile "${dotfiles}/zsh/zprofile"
