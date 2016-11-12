{% import 'dotfiles.jinja' as dotfiles with context %}

# * install
tmux-install:
  pkg.installed:
    - name: tmux

# * config
tmux-config:
  file.managed:
    - name: {{ dotfiles.home }}/.tmux.conf
    - source: salt://tmux/config
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
