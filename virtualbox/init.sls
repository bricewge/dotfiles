{% import 'dotfiles.jinja' as dotfiles with context %}


{% if salt['file.file_exists' ](dotfiles.home+'/.config/VirtualBox/VirtualBox.xml') %}
# If the config is already in place
virtualbox.config.present:
  file.replace:
    - name: {{ dotfiles.home }}/.config/VirtualBox/VirtualBox.xml
    - pattern: "VirtualBox VMs"
    - repl: "vm"
    - order: 91
  # If the config has to be updated stop any VirtuaBox processes before actually editing it
  process.absent:
    - name: VirtualBox
    - user: {{ dotfiles.user }}
    - signal: 9
    - order: 90

{% else %}
# If the config not there
virtualbox.config.absent:
  file.managed:
    - name: {{ dotfiles.home }}/.config/VirtualBox/VirtualBox.xml
    - source: salt://virtualbox/VirtualBox.xml
    - user: {{ dotfiles.user }}
    - group: {{ dotfiles.group }}
    - mode: 644
    - dir_mode: 755
    - makedirs: True
    - template: jinja
    - context:
        home: {{ dotfiles.home }}

{% endif %}
