include config

ok github ~/.emacs.d syl20bnr/spacemacs
ok symlink ~/.spacemacs $dotfiles/emacs/spacemacs.conf
# ok symlink ~/.emacs.d/private/bricewge $dotfiles/emacs/private/bricewge
ok symlink ~/.emacs.d/bookmarks $dotfiles/emacs/bookmarks

for dir in ${dotfiles}/emacs/private/*/ ; do
    ok symlink "${HOME}/.emacs.d/private/$(basename ${dir})" \
       "${dotfiles}/emacs/private/$(basename ${dir})"
done

if [[ $OS == "macos" ]]; then
    #ok brew-tap d12frosted/emacs-plus
    #ok brew emacs-plus
    ok cask emacs $appdir
    # fonts
    curl -L https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.tar.gz -o /tmp/source-code-pro.tar.gz
    tar --strip-components=1 -zxvf source-code-pro.tar.gz source-code-pro-2.030R-ro-1.050R-it/OTF/
    mv OTF
    mkdir -p $HOME/Library/Fonts/source-code-pro
fi
#if [ ! -e ~/Library/Fonts]

# * emacs-old
ok directory ~/.emacs-old.d
ok symlink ~/.emacs-old.d/init.el $dotfiles/emacs/emacs-old/init.el
ok symlink ~/.emacs-old.d/bricewge.org $dotfiles/emacs/emacs-old/bricewge.org
ok symlink ~/.emacs-old.d/custom.el $dotfiles/emacs/emacs-old/custom.el
ok symlink ~/.emacs-old.d/bookmarks "$dotfiles/emacs/bookmarks"
ok symlink ~/.emacs-old.d/org $dotfiles/emacs/org
ok directory ~/.local/bin
ok symlink ~/.local/bin/emacs-old $dotfiles/emacs/emacs-old/emacs-old
