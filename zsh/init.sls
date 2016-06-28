{% import 'dotfiles.jinja' as dotfiles with context %}

include:
  - env

zsh.install:
  pkg.installed:
    - name: zsh

zsh.antigen:
  git.latest:
    - name: https://github.com/zsh-users/antigen.git
    - target: {{ dotfiles.home }}/.antigen
    - rev: master
    - user: {{ dotfiles.user }}

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
      - git: zsh.antigen

# Install trash-cli as rm is inactivated by zshrc
{% if grains['os'] == 'Debian' %}
zsh.trash:
  pkg.installed:
    - name: trash-cli
{% elif grains['os'] == 'MacOS' %}
zsh.trash:
  pkg.installed:
    - name: trash
{% endif %}

zsh.default:
  user.present:
    - name: {{ dotfiles.user }}
    - shell: /bin/zsh
    - require:
      - file: zsh.zshrc
