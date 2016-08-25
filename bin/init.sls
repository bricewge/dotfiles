{% import 'dotfiles.jinja' as dotfiles with context %}

bin.init:
  file.recurse:
    - name: {{ dotfiles.home }}/.local/bin
    - source: salt://bin
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - dir_mode: 755
    - file_mode: 755
    - exclude_pat: "*sls"
