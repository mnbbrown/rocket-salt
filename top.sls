base:
  '*':
    - base
    - debian-auto-upgrades
    - monit
    - logrotate
    - docker
    - collectd
    - collectd.disk
    - collectd.syslog
    - collectd.interface

  'roles:zookeeper':
    - match: grain
    - zookeeper

  'roles:mesos-master':
    - match: grain
    - openvpn

  'roles:mesos-slave':
    - match: grain
