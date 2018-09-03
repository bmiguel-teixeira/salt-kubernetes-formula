{%- from "kubernetes/map.jinja" import common with context %}

kubeproxy.svc:
  file.managed:
    - name: {{common.base_path}}/kubeproxy.yml
    - source: salt://kubernetes/master/files/services/kubeproxy.yml.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - defaults:
        image: {{common.docker_binaries}}:v{{common.version}}

dashboards.svc:
  file.managed:
    - name: {{common.base_path}}/dashboards.yml
    - source: salt://kubernetes/master/files/services/dashboards.yml.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - defaults:
        image: {{common.docker_binaries}}:v{{common.version}}