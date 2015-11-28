{% import 'dotfiles.jinja' as dotfiles with context %}

enchant.fr_FR.copy:
  file.copy:
    - name: {{ dotfiles.fileroot }}/enchant/fr_FR.dic
    - source: {{ dotfiles.home }}/.config/enchant/fr_FR.dic
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 644
    - dir_mode: 755
    - makedirs: True
    - force: True

enchant.fr_FR:
    file.managed:
    - name: {{ dotfiles.home }}/.config/enchant/fr_FR.dic
    - source: salt://enchant/fr_FR.dic
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 644
    - dir_mode: 755
    - makedirs: True
