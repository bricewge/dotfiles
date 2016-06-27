{% import 'dotfiles.jinja' as dotfiles with context %}
{% from 'emacs/map.jinja' import emacs with context %}

include:
  - emacs

# * custom.el
emacs.custom.copy:
  file.copy:
    - name: {{ dotfiles.fileroot }}/emacs/custom.el
    - source: {{ dotfiles.home }}/.emacs.d/custom.el
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
    - force: True

emacs.custom:
    file.managed:
    - name: {{ dotfiles.home }}/.emacs.d/custom.el
    - source: salt://emacs//custom.el
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
    - require:
      - file: emacs.bricewge

# * bookmarks
emacs.bookmarks.copy:
  file.copy:
    - name: {{ dotfiles.fileroot }}/emacs/bookmarks
    - source: {{ dotfiles.home }}/.emacs.d/bookmarks
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
    - force: True

emacs.bookmarks:
    file.managed:
    - name: {{ dotfiles.home }}/.emacs.d/bookmarks
    - source: salt://emacs/bookmarks
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
    - require:
      - file: emacs.bricewge
