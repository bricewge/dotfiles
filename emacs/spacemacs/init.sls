{% import 'dotfiles.jinja' as dotfiles with context %}

spacemacs.install:
  git.latest:
    - name: https://github.com/syl20bnr/spacemacs.git
    - target: {{ dotfiles.home }}/.spacemacs.d
    - user: {{ dotfiles.user }}
  file.symlink:
    - name: {{ dotfiles.home }}/.spacemacs.d/home/.emacs.d
    - target: {{ dotfiles.home }}/.spacemacs.d
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 755
    - dir_mode: 755
    - makedirs: True
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
