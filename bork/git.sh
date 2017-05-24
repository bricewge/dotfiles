dotfiles="$HOME/.dotfiles"

ok symlink ~/.gitconfig $dotfiles/git/config
ok symlink ~/.gitignore $dotfiles/git/ignore
ok github ~/.local/src/git-fire "bricewge/git-fire"
ok symlink ~/.local/bin/git-fire ~/.local/src/git-fire/git-fire
if [[ $OS="macos" ]];then
    ok brew git-crypt
    ok brew git-subrepo
fi
