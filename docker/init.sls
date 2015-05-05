bridge-utils:
  pkg.installed

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1

crb0:
  container_bridge.ensure:
    - cidr:  
    - mtu: 1460

purge-old-docker:
  pkg.removed:
    - pkgs:
      - lxc-docker-1.2.0
      - lxc-docker-1.3.0
      - lxc-docker-1.3.1
      - lxc-docker-1.3.2
      - lxc-docker-1.3.3
      - lxc-docker-1.4.0
      - lxc-docker-1.4.1

/etc/default/docker:
  file:
    - managed
    - source: salt://docker/defaults
    - template: jinja2
    - user: root
    - group: root
    - mode: 644
    - makedirs: true

{% set storage_base='https://get.docker.com/ubuntu/pool/main/l/lxc-docker/' %}
{% set deb='lxc-docker_1.5.0_amd64.deb' %}
{% set deb_hash='sha1=ba4db088a741c15311406780d828fa6a6341fb40' %}
{% set docker_ver='1.5.0' %}

/var/cache/docker-install/{{ deb }}:
  file.manage:
    - source: {{ storage_base }}{{ deb }}
    - source_hash: {{ deb_hash }}
    - user: root
    - group: root
    - mode: 644
    - makedirs: true

lxc-docker-{{ docker_ver }}:
  pkg.installed:
    - sources:
      - lxc-docker-{{ docker_ver }}: /var/cache/docker-install/{{ deb }}

docker:
  service.running:
    - enable: True
    - require: 
      - pkg: lxc-docker-1.5.0
    - watch:
      - file: /etc/default/docker
      - container_bridge: cbr0
      - pkg: lxc-docker-{{ docker_ver }}

