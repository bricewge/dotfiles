{% import 'dotfiles.jinja' as dotfiles with context %}

{% if salt['file.file_exists'](dotfiles.home ~ '/.arduino15/preferences.txt') %}
arduino.directory:
  file.directory:
    - name: {{ dotfiles.home }}/divers/arduino
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - makedirs: True

arduino.sketchbook:
  file.replace:
    - name: {{ dotfiles.home }}/.arduino15/preferences.txt
    - pattern: ^sketchbook.path=.*
    - repl: sketchbook.path={{ dotfiles.home }}/divers/arduino
    - require:
      - file: arduino.directory
{% endif %}
