{% import 'dotfiles.jinja' as dotfiles with context %}
{% from 'zsh/map.jinja' import zsh with context %}

include:
  - env
# * Install
zsh.install:
  pkg.installed:
    - name: zsh

# * Config
zsh.zshenv:
  file.managed:
    - name: {{ dotfiles.home }}/.zshenv
    - source: salt://zsh/zshenv
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644

zsh.zprofile:
  file.managed:
    - name: {{ dotfiles.home }}/.zprofile
    - source: salt://zsh/zprofile
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
    - require:
      - file: env.profile
  
zsh.zshrc:
  file.managed:
    - name: {{ dotfiles.home }}/.zshrc
    - source: salt://zsh/zshrc
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
    - template: jinja
    - require:
      - archive: zsh.antibody

zsh.zpreztorc:
  file.managed:
    - name: {{ dotfiles.home }}/.zpreztorc
    - source: salt://zsh/zpreztorc
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
    - template: jinja

# Use =zsh= as the default shell
zsh.default:
  user.present:
    - name: {{ dotfiles.user }}
    - shell: /bin/zsh
    - require:
      - file: zsh.zshrc

# * other software
# ** antibody - zsh package manager
zsh.antibody:
  archive.extracted:
    - name: {{ dotfiles.home }}/.local/bin/
    - source: {{ zsh.antibody.source }}
    - source_hash: {{ zsh.antibody.hash }}
    - archive_format: tar
    - options: ' ./antibody'
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - if_missing: {{ dotfiles.home }}/.local/bin/antibody

# ** trash
# Install trash-cli as rm is desactivated by zshrc
zsh.trash:
  pkg.installed:
    - name: {{ zsh.trash }}
{% if grains['os'] == 'Debian' %}
# ** command-not-found
# Availaible in AUR for Archlinux
zsh.command-not-found:
  pkg.installed:
    - name: command-not-found
{% endif %}
