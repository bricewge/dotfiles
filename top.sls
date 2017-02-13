base:
  '*':
    - bin
    - emacs
    - enchant
    - env
    - font
    - git
    - gpg
    - isync
    - tmux
    - offlineimap
    - texlive
    - zsh
  'not G@os:MacOS':
    - termite
  'I@dotfiles:graphics:True':
    - arduino
    - bspwm
    - redshift
    - mpv
    - virtualbox
  'I@dotfiles:decrypted:True':
    - ssh
    - emacs.personal
