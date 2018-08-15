{%- from "kubernetes/map.jinja" import common with context %}

etcd.svc:
  file.managed:
    - name: {{common.manifests_path}}/etcd.yml
    - source: salt://kubernetes/master/files/manifests/etcd.yml.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - defaults:
        controllers:
          - kubm1=https://10.0.1.5:2380
          - kubm2=https://10.0.1.4:2380

api.svc:
  file.managed:
    - name: {{common.manifests_path}}/api_server.yml
    - source: salt://kubernetes/master/files/manifests/apiserver.yml.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - defaults:
        image: {{common.docker_binaries}}:{{common.version}}

controller.svc:
  file.managed:
    - name: {{common.manifests_path}}/controller.yml
    - source: salt://kubernetes/master/files/manifests/controller.yml.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - defaults:
        image: {{common.docker_binaries}}:{{common.version}}

scheduler.svc:
  file.managed:
    - name: {{common.manifests_path}}/scheduler.yml
    - source: salt://kubernetes/master/files/manifests/scheduler.yml.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - defaults:
        image: {{common.docker_binaries}}:{{common.version}}