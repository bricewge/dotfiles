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

termite.config:
  file.managed:
    - name: {{ dotfiles.home }}/.config/termite/config
    - source: salt://termite/config
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 644
    - dir_mode: 755
    - makedirs: True