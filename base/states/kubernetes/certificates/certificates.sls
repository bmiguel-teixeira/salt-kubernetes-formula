{%- from "kubernetes/map.jinja" import common with context %}

dummy.working.dir:
  file.directory:
    - name: {{common.kubernetes_base_path}}

generate_private_key:
  cmd.run:
    - name: openssl genrsa -out {{common.api_server_key}} 2048
    - unless: test -e {{common.api_server_key}}

csr.conf:
  file.managed:
    - name: {{common.kubernetes_base_path}}/csr.conf
    - source: salt://kubernetes/certificates/files/csr.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644

generate_request:
  cmd.run:
    - name: openssl req -new -key {{common.api_server_key}} -out {{common.kubernetes_base_path}}/server.csr -config {{common.kubernetes_base_path}}/csr.conf
    - unless: test -e {{common.kubernetes_base_path}}/server.csr

generate_signed_crt:
  cmd.run:
    - name: openssl x509 -req -in {{common.kubernetes_base_path}}/server.csr -CA {{common.ca_crt}} -CAkey {{common.ca_key}} -CAcreateserial -out {{common.api_server_crt}} -days 10000 -extensions v3_ext -extfile {{common.kubernetes_base_path}}/csr.conf
    - unless: test -e {{common.api_server_crt}}
