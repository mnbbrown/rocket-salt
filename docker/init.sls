cbr0:
  container_bridge.ensure:
    - cidr: 10.0.0.0/8
    - mtu: 1460

docker-dependencies:
   pkg.installed:
    - pkgs:
      - iptables
      - ca-certificates
      - lxc

docker-repo:
    pkgrepo.managed:
      - humanname: Docker repo
      - name: deb http://get.docker.io/ubuntu docker main
      - file: /etc/apt/sources.list.d/docker.list
      - keyid: d8576a8ba88d21e9
      - keyserver: keyserver.ubuntu.com
      - require_in:
          - pkg: lxc-docker
      - require:
        - pkg: pkg-core

lxc-docker:
  pkg.latest:
    - fromrepo: docker
    - refresh: True
    - require:
      - pkg: docker-dependencies

docker-service:
  service.running:
    - name: docker
    - enable: True
