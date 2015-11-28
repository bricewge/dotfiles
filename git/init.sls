{% import 'dotfiles.jinja' as dotfiles with context %}

git.config:
  file.managed:
    - name: {{ dotfiles.home }}/.config/git/config
    - source: salt://git/config
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 644
    - dir_mode: 755
    - makedirs: True

git.ignore:
  file.managed:
    - name: {{ dotfiles.home }}/.config/git/ignore
    - source: salt://git/ignore
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 644
    - dir_mode: 755
    - makedirs: True