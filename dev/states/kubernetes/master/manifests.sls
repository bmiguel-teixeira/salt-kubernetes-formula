{%- from "kubernetes/map.jinja" import common with context %}

api.svc:
  file.managed:
    - name: {{common.manifests_path}}/api_server.yml
    - source: salt://kubernetes/master/files/manifests/apiserver.yml.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - defaults:
        image: {{common.docker_binaries}}:v{{common.version}}

controller.svc:
  file.managed:
    - name: {{common.manifests_path}}/controller.yml
    - source: salt://kubernetes/master/files/manifests/controller.yml.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - defaults:
        image: {{common.docker_binaries}}:v{{common.version}}

scheduler.svc:
  file.managed:
    - name: {{common.manifests_path}}/scheduler.yml
    - source: salt://kubernetes/master/files/manifests/scheduler.yml.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - defaults:
        image: {{common.docker_binaries}}:v{{common.version}}