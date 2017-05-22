appdir="--appdir=$HOME/Applications"
dotfiles="$HOME/.dotfiles"

ok brew
#ok brew-tap d12frosted/emacs-plus
#ok brew emacs-plus
ok cask emacs $appdir

ok github ~/.emacs.d syl20bnr/spacemacs
#ok symlink ~/.emacs.d ~/.spacemacs.d
#ok symlink ~/.spacemacs $dotfiles/emacs/spacemacs/config

ok directory ~/.local/bin
ok symlink ~/.local/bin/spacemacs $dotfiles/emacs/spacemacs/spacemacs

# fonts
curl -L https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.tar.gz -o /tmp/source-code-pro.tar.gz
tar --strip-components=1 -zxvf source-code-pro.tar.gz source-code-pro-2.030R-ro-1.050R-it/OTF/
mv OTF
mkdir -p $HOME/Library/Fonts/source-code-pro

#if [ ! -e ~/Library/Fonts]
