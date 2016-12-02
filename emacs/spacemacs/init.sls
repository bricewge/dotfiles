{% import 'dotfiles.jinja' as dotfiles with context %}

spacemacs.install:
  git.latest:
    - name: https://git.bricewge.fr/bricewge/spacemacs.git
    - target: {{ dotfiles.home }}/.spacemacs.d
    - user: {{ dotfiles.user }}
    - rev: custom
  file.managed:
    - name: {{ dotfiles.home }}/.local/bin/spacemacs
    - source: salt://emacs/spacemacs/spacemacs
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 755
    - require:
      - git: spacemacs.install

spacemacs.config:
  file.managed:
    - name: {{ dotfiles.home }}/.spacemacs
    - source: salt://emacs/spacemacs/config
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644

{% if grains['os_family'] == 'Arch' or grains['os_family'] == 'Debian' %}
spacemacs.desktop:
  file.managed:
    - name: {{ dotfiles.home }}/.local/share/applications/spacemacs.desktop
    - source: salt://emacs/spacemacs/spacemacs.desktop
    - template: jinja
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 755
    - dir_mode: 755
    - makedirs: True
    - require:
      - git: spacemacs.install
{% endif %}

# * misc
# spacemacs clang completion
spacemacs-cc_args:
  file.managed:
    - name: {{ dotfiles.home }}/.local/bin/cc_args
    - source: https://raw.githubusercontent.com/Rip-Rip/clang_complete/0402f05a03a7769268e0e00661d212007074ea2c/bin/cc_args.py
    - source_hash: sha256=3d335ad9d778e39e50ace5c64e693f08af5ca97b3f89b9e3833e5be663a0cd3a
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 755

# Need AUR support from salt
# spacemacs-tern:
#   pkg.installed:
#     - name: nodejs-tern
