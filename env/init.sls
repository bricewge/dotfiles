{% import "dotfiles.jinja" as dotfiles with context%}

env.profile:
  file.managed:
    - name: {{ dotfiles.home }}/.profile
    - source: salt://env/profile
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
    - template: jinja
