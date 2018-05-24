docker_repo:
 pkgrepo.managed:
  - humanname: docker_engine
  - name: deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable
  - dist: xenial
  - file: /etc/apt/sources.list
  - keyid: 0EBFCD88
  - keyserver: keyserver.ubuntu.com

docker_engine:
 pkg.installed:
  - name: docker-ce
  - version: '18.03.0~ce-0~ubuntu'
  - refresh: True