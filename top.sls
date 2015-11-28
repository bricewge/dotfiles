base:
  '*':
    - bspwm
    - emacs
    - enchant
    - font
    - redshift
    - offlineimap
    - termite
    - texlive
    - zsh
  'dotfiles:user:bricewge':
    - match: pillar
    - git
    - gpg
  'dotfiles:decrypted:True':
    - match: pillar
    - ssh
