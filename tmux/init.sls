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

tmux-plugin-manager:
  file.directory:
    - name: {{ dotfiles.home }}/.tmux/plugins/
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 755
    - makedirs: True
  git.latest:
    - name: https://github.com/tmux-plugins/tpm.git
    - target: {{ dotfiles.home }}/.tmux/plugins/tpm
    - branch: master
    - require:
      - file: tmux-plugin-manager
