{%- from "kubernetes/map.jinja" import common with context %}

docker_container.running:
  - name: kubelet
  - image: "{{common.docker_base_binaries}}:{{common.version}}"
  - network_mode: host
  - binds:
    - /etc/kubernetes/manifests:/etc/kubernetes/manifests