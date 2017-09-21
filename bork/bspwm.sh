include config

ok symlink $HOME/.xinitrc "${dotfiles}/bspwm/xinitrc"
ok symlink $HOME/.Xresources "${dotfiles}/bspwm/Xresources"
ok symlink $HOME/.xsession "${dotfiles}/bspwm/xsession"

ok directory ~/.config
ok symlink ~/.config/compton.conf "${dotfiles}/bspwm/compton.conf"

ok symlink ~/.config/polybar "${dotfiles}/polybar"
ok symlink ~/.config/polybar/colors "${dotfiles}/polybar/colors-default"
