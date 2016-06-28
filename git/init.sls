{% import 'dotfiles.jinja' as dotfiles with context %}

git.install:
  pkg.installed:
    - name: git

git.config:
  file.managed:
    - name: {{ dotfiles.home }}/.config/git/config
    - source: salt://git/config
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
    - dir_mode: 755
    - makedirs: True

git.ignore:
  file.managed:
    - name: {{ dotfiles.home }}/.config/git/ignore
    - source: salt://git/ignore
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
    - dir_mode: 755
    - makedirs: True

{% if grains['os'] != 'Arch' %}
# On arch it need to be install from AUR
git-crypt.install:
  pkg.installed:
    - name: git-crypt
    - fromrepo: testing
{% endif %}
