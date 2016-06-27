{% import "dotfiles.jinja" as dotfiles with context%}

isync-install:
  pkg.installed:
    - name: isync

isync-config:
  file.managed:
    - name: {{ dotfiles.home }}/.mbsyncrc
    - source: salt://isync/mbsync.conf
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
