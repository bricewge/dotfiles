{% import 'dotfiles.jinja' as dotfiles with context %}

# Don't apply this state otherwise it will modify your system
# rather than your user configuration!

# ** GnuPG
gpg.install:
  pkg.installed:
{% if grains['os'] != 'MacOS' %}
    - name: gnupg2
{% elif grains['os'] == 'MacOS' %}
    - pkgs:
      - gnupg21
      - pinentry-mac
    - tap: homebrew/versions
{% endif %}

# Retrieve my GPG public key
gnupg.key.bricewge:
  gpg.present:
    - name: 0x3d36caa0116f0f99
    - user: {{ dotfiles.user }}
    - keyserver: pool.sks-keyservers.net

{% if grains['os'] != 'MacOS' %}
# ** envoy
envoy.install:
  pkg.installed:
    - name: envoy
  service.running:
    - name: envoy@gpg-agent.socket
    - enable: True
    - require:
      - pkg: envoy.install

envoy.login:
  file.append:
    - name: /etc/pam.d/login
    - text: "session    optional     pam_envoy.so          gpg-agent"
    - require:
      - pkg: envoy.install

envoy.gdmauto:
  file.append:
    - name: /etc/pam.d/gdm-autologin
    - text: "session    optional     pam_envoy.so          gpg-agent"
    - require:
      - pkg: envoy.install

envoy.gdmpsswd:
  file.append:
    - name: /etc/pam.d/gdm-password
    - text: "session    optional     pam_envoy.so          gpg-agent"
    - require:
      - pkg: envoy.install

# Needed until envoy work with GnuPG >=2.1.13
envoy.fix:
  file.symlink:
    - name: {{ dotfiles.home }}/.gnupg/S.gpg-agent
    - target: /run/user/{{ dotfiles.uid }}/gnupg/S.gpg-agent
    - require:
      - service: envoy.install
      - gpg: gnupg.key.bricewge

# ** pcscd
envoy.smartcard:
  pkg.installed:
    - pkgs:
      - ccid
      - opensc
      - libusb-compat
  service.running:
    - name: pcscd.socket
    - enable: True
    - require:
      - pkg: envoy.smartcard
{% endif %}
