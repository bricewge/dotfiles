{% import 'dotfiles.jinja' as dotfiles with context %}
{% from 'emacs/map.jinja' import emacs with context %}

# * Install
emacs.install:
  pkg.installed:
    - pkgs: {{ emacs.pkgs }}

# * Configuration
emacs.bricewge:
  file.managed:
    - name: {{ dotfiles.home }}/.emacs.d/bricewge.org
    - source: salt://emacs/bricewge.org
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 644
    - dir_mode: 755
    - makedirs: True
    - template: jinja

emacs.init:
  cmd.run:
    - name: |
        emacs -Q --batch --eval \
        "(progn
        (require 'ob-tangle)
        (org-babel-tangle-file \"~/.emacs.d/bricewge.org\" \"~/.emacs.d/bricewge.el\")
        )"
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - cwd: {{ dotfiles.home }}
    - onchanges:
      - file: emacs.bricewge

# * Service
emacs.service:
  file.managed:
    - name: {{ dotfiles.home }}/.config/systemd/user/emacs.service
    - source: salt://emacs/emacs.service
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 644
    - dir_mode: 755
    - makedirs: True

# Hackish way to enable the emacs service; as user services seems to
# dosen't be supported by saltstack yet.
emacs.enable:
  file.symlink:
    - name: {{ dotfiles.home }}/.config/systemd/user/default.target.wants/emacs.service
    - target: {{ dotfiles.home }}/.config/systemd/user/emacs.service
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 644
    - dir_mode: 755
    - makedirs: True
    - require:
      - file: emacs.service

# * Directories
emacs.orgdir:
  file.recurse:
    - name: {{ dotfiles.home }}/.emacs.d/org
    - source: salt://emacs/org
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - file_mode: 644
    - dir_mode: 755
    - include_empty: True
    - require:
      - file: emacs.bricewge

# * Emacs client
emacsclient.desktop:
  file.managed:
    - name: {{ dotfiles.home }}/.local/share/applications/emacs-client.desktop
    - source: salt://emacs/emacs-client.desktop
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 755
    - dir_mode: 755
    - makedirs: True