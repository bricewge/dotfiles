{% import 'dotfiles.jinja' as dotfiles with context %}

{% if grains['os'] == 'Arch' %}
bspwm.install:
  pkg.installed:
    - pkgs:
      - adwaita-icon-theme
      - bspwm
      - conky
      - dmenu
      - sxhkd
      - feh
      - unclutter
      - xorg-xset
      - xorg-xsetroot
# From AUR
#      - compton
#      - lemonbar-xft-git
{% endif %}

bspwm.panel:
  file.recurse:
    - name: {{ dotfiles.home }}/.config/bspwm/panel/
    - source: salt://bspwm/panel/
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - file_mode: 644
    - dir_mode: 755

bspwm.conf:
  file.managed:
    - name: {{ dotfiles.home }}/.config/bspwm/bspwmrc
    - source: salt://bspwm/bspwmrc
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 644
    - require:
      - file: bspwm.panel

bspwm.sxhkdrc:
  file.managed:
    - name: {{ dotfiles.home }}/.config/sxhkd/sxhkdrc
    - source: salt://bspwm/sxhkdrc
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 644
    - dir_mode: 755
    - makedirs: True

bspwm.compton:
  file.managed:
    - name: {{ dotfiles.home }}/.config/compton.conf
    - source: salt://bspwm/compton.conf
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 644

bspwm.Xresources:
  file.managed:
    - name: {{ dotfiles.home }}/.Xresources
    - source: salt://bspwm/Xresources
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 644

bspwm.xinitrc:
  file.managed:
    - name: {{ dotfiles.home }}/.xinitrc
    - source: salt://bspwm/xinitrc
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 755
    - template: jinja
