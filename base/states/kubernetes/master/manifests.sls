{%- from "kubernetes/map.jinja" import common with context %}


{{common.manifests_path}}/etcd.yml:
  file.managed:
    - source: salt://kubernetes/master/files/etcd.yml.jinja
    - template: jinja
