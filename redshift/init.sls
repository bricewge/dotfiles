{% import 'dotfiles.jinja' as dotfiles with context %}
{% from 'redshift/map.jinja' import redshift with context %}

redshift.install:
  pkg.installed:
    - name: {{ redshift }}

redshift.conf:
  file.managed:
    - name: {{ dotfiles.home }}/.config/redshift.conf
    - source: salt://redshift/redshift.conf
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
    - dir_mode: 755
    - makedirs: True

redshift.autostart:
  file.symlink:
    - name: {{ dotfiles.home }}/.config/autostart/redshift-gtk.desktop
    - target: /usr/share/applications/redshift-gtk.desktop
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 755
    - dir_mode: 755
    - makedirs: True
    - require:
      - pkg: redshift.install