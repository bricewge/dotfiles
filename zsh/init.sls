{% import 'dotfiles.jinja' as dotfiles with context %}

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
    - group: {{ dotfiles.user }}
    - mode: 644

zsh.profile:
  file.managed:
    - name: {{ dotfiles.home }}/.profile
    - source: salt://zsh/profile
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 644
  
zsh.zshrc:
  file.managed:
    - name: {{ dotfiles.home }}/.zshrc
    - source: salt://zsh/zshrc
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.user }}
    - mode: 644
    - require:
      - git: zsh.antigen