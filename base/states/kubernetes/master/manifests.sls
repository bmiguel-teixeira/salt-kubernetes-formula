{%- from "kubernetes/map.jinja" import common with context %}

etcd.svc:
  file.managed:
    - name: {{common.manifests_path}}/etcd.yml
    - source: salt://kubernetes/master/files/manifests/etcd.yml.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644

