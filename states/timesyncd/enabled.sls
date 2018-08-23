{% set timeserver = salt['pillar.get']('raspalt:timesyncd:timeserver', [])|join(' ') %}
/etc/systemd/timesyncd.conf:
  pkg.installed:
    - pkgs:
      - systemd
  file.managed:
    - source: salt://{{ slspath }}/timesyncd.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
        timeserver: {{ timeserver }}
  cmd.run:
   - name: timedatectl set-ntp true
   - unless: 'timedatectl status | grep --quiet -E "NTP synchronized: yes"'
   - env:
     - LC_ALL: 'en_US.utf8'

timesyncd_running:
  service.running:
    - name: systemd-timesyncd

ntp_dead:
  service.dead:
    - name: ntp

ntp_disabled:
  service.disabled:
    - name: ntp
