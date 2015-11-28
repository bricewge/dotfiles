{% import 'dotfiles.jinja' as dotfiles with context %}

git.gitconfig:
  file.managed:
    - name: {{ dotfiles.home }}/.gitconfig
    - source: salt://git/gitconfig
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 644