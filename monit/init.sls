monit:
  pkg:
    - installed

/etc/monit/conf.d/collectd:
  file:
    - managed
    - source: salt://monit/collectd

{% if 'mesos-master' in grains.get('roles', []) %}

/etc/monit/conf.d/mesos-master:
  file:
    - managed
    - source: salt://monit/mesos-master

{% endif %}

{% if 'mesos-slave' in grains.get('roles', []) %}

/etc/monit/conf.d/docker:
  file:
    - managed
    - source: salt://monit/docker
    - user: root
    - group: root
    - mode: 664

{% endif %}

monit-servce:
  service:
    - running
    - name: monit
    - watch:
      - pkg: monit
      - file: /etc/monit/conf.d/*
