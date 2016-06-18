{% import 'dotfiles.jinja' as dotfiles with context %}

font.meslo:
  file.recurse:
    - name: {{ dotfiles.home }}/.local/share/fonts/
    - source: salt://font/meslo/
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - file_mode: 644
    - dir_mode: 755

font.powerline:
  file.managed:
    - name: {{ dotfiles.home }}/.local/share/fonts/PowerlineSymbols.otf
    - source: salt://font/PowerlineSymbols.otf
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 644
    - require:
      - file: font.meslo

font.fontconfig:
  file.recurse:
    - name: {{ dotfiles.home }}/.config/fontconfig/
    - source: salt://font/fontconfig/
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - file_mode: 644
    - dir_mode: 755

font.update:
  cmd.run:
    - name: fc-cache -v
    - runas: {{ dotfiles.user }}
    - cwd: {{ dotfiles.home }}
    - onchanges:
      - file: font.meslo
      - file: font.powerline
