{% import 'dotfiles.jinja' as dotfiles with context %}

# Installation disabled for Archlinux because texlive-most
# is a group package, which isn't yet supported by saltstack.
{% if grains['os'] == 'Debian' %}
texlive.install:
  pkg.installed:
    - name: texlive
{% endif %}

beamer.themes:
  file.recurse:
    - name: {{ dotfiles.home }}/.texmf/tex/latex/beamer/
    - source: salt://texlive/beamer
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - file_mode: 644
    - dir_mode: 755