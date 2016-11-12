{% import 'dotfiles.jinja' as dotfiles with context %}

mpv.install:
  pkg.installed:
    - name: mpv

mpv.scripts:
  file.directory:
    - name: {{ dotfiles.home }}/.config/mpv/scripts
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 755

mpv.config:
  file.managed:
    - name: {{ dotfiles.home }}/.config/mpv/mpv.conf
    - source: salt://mpv/config
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
    - dir_mode: 755
    - makedirs: True
    - require:
      - pkg: mpv.install
      - file: mpv.scripts

mpv.filenavigator:
  git.latest:
    - name: https://github.com/donmaiq/mpv-filenavigator.git
    - target: {{ dotfiles.home }}/.config/mpv/filenavigator
    - user: {{ dotfiles.user }}
    - branch: master
    - require:
      - file: mpv.config
  file.symlink:
    - name: {{ dotfiles.home }}/.config/mpv/scripts/filenavigator.lua
    - target: {{ dotfiles.home }}/.config/mpv/filenavigator/navigator.lua
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - require:
      - git: mpv.filenavigator

