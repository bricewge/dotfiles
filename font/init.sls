{% import 'dotfiles.jinja' as dotfiles with context %}
{% from 'font/map.jinja' import font with context %}

font.meslo:
  file.recurse:
    - name: {{ dotfiles.home }}{{ font.path }}/
    - source: salt://font/meslo/
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - file_mode: 644
    - dir_mode: 755

font.powerline:
  file.managed:
    - name: {{ dotfiles.home }}{{ font.path }}/PowerlineSymbols.otf
    - source: salt://font/PowerlineSymbols.otf
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
    - require:
      - file: font.meslo

font.fontconfig.install:
  pkg.installed:
    - name: fontconfig

font.fontconfig:
  file.recurse:
    - name: {{ dotfiles.home }}/.config/fontconfig/
    - source: salt://font/fontconfig/
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - file_mode: 644
    - dir_mode: 755

font.update:
  cmd.run:
    - name: fc-cache -v {{ dotfiles.home }}{{ font.path }}
    - runas: {{ dotfiles.user }}
    - cwd: {{ dotfiles.home }}
    - onchanges:
      - file: font.meslo
      - file: font.powerline
