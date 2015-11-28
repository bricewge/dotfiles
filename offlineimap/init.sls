{% import "dotfiles.jinja" as dotfiles with context%}

offlineimap.install:
  pkg.installed:
    - name: offlineimap

offlineimap.utf7:
  file.managed:
    - name: {{ dotfiles.home }}/.config/offlineimap/utf7.py
    - source: salt://offlineimap/utf7.py
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 755
    - makedirs: True
        
# This file contain passwords and logins
offlineimap.config:
  file.managed:
    - name: {{ dotfiles.home }}/.config/offlineimap/config
    - source: salt://offlineimap/config
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 600
    - template: jinja
    - require:
      - file: offlineimap.utf7


