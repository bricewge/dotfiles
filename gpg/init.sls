{% import 'dotfiles.jinja' as dotfiles with context %}

# Don't apply this state otherwise it will modify your system
# rather than your user configuration!

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