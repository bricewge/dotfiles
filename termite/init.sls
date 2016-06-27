{% import "dotfiles.jinja" as dotfiles with context%}

{% if grains['os'] == 'Arch' %}
termite.install:
  pkg.installed:
    - name: termite
{% endif %}
      
termite.terminfo:
  file.managed:
    - name: /etc/terminfo/x/xterm-termite
    - source: salt://termite/xterm-termite
    - user: root
    - group: root
    - mode: 644
    - dir_mode: 755
    - makedirs: True

termite.dark:
  file.managed:
    - name: {{ dotfiles.home }}/.config/termite/dark
    - source: salt://termite/dark
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
    - dir_mode: 755
    - makedirs: True

termite.light:
  file.managed:
    - name: {{ dotfiles.home }}/.config/termite/light
    - source: salt://termite/light
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
    - require:
      - file: termite.dark

termite.config:
  file.symlink:
    - name: {{ dotfiles.home }}/.config/termite/config
    - target: {{ dotfiles.home }}/.config/termite/dark
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
    - force: True
    - require:
      - file: termite.dark

termite.theme:
  file.managed:
    - name: {{ dotfiles.home }}/.local/bin/theme
    - source: salt://termite/theme
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 755
    - dir_mode: 755
    - makedirs: True

# Add a contextual menu in file managers to start termite in the
# current directory. In Nautilus it need "nautilus-actions" installed.
termite.filemanager:
  file.managed:
    - name: {{ dotfiles.home }}/.local/share/file-manager/actions/open-in-termite.desktop
    - source: salt://termite/open-in-termite.desktop
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
    - dir_mode: 755
    - makedirs: True
