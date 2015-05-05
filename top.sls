base:
  '*':
    - base
    - debian-auto-upgrades
    - monit
    - logrotate
    - collectd
    - docker

  'roles:zookeeper'
    - match: grain
    - zookeeper

  'roles:mesos-master':
    - match: grain
    - openvpn

  'roles:mesos-slave':
    - match: grain
