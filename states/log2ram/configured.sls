{% set enabled = salt['pillar.get']('raspalt:log2ram:enabled', True) %}
/var/log/:
  pkg.installed:
    - pkgs:
      - mount
      - coreutils
      - systemd
      - tar
  cmd.script:
{% if enabled %}
    - source: salt://log2ram/enabled.sh
{% else %}
    - source: salt://log2ram/disabled.sh
{% endif %}
    - stateful: True
