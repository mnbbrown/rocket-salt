monit:
  pkg:
    - installed

{% if 'mesos-master' in grains.get('roles', []) %}

/etc/monit/conf.d/mesos-master:
  file:
    - managed
    - source: salt://monit/mesos-master

{% endif %}

/etc/monit/conf.d/docker:
  file:
    - managed
    - source: salt://monit/docker
    - user: root
    - group: root
    - mode: 664

monit-servce:
  service:
    - running
    - name: monit
    - watch:
      - pkg: monit
      - file: /etc/monit/conf.d/*
