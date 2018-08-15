{%- from "kubernetes/map.jinja" import common with context %}

certs_path.working.dir:
  file.directory:
    - name: {{common.certs_path}}
    - group: root
    - dir_mode: 755

generate_ca_private_key:
  cmd.run:
    - name: openssl genrsa -out {{common.ca_key}} 2048
    - unless: test -e {{common.ca_key}}

generate_ca_certificate:
  cmd.run:
    - name: openssl req -x509 -new -nodes -key {{common.ca_key}} -subj "/CN={{common.cluster_name}}" -days 10000 -out {{common.ca_crt}}
    - unless: test -e {{common.ca_crt}}

copy.ca_key:
  module.run:
    - name: cp.push
    - path: {{common.ca_key}}
    - remove_source: True

copy.ca_crt:
  module.run:
    - name: cp.push
    - path: {{common.ca_crt}}
    - remove_source: True