{%- from "kubernetes/map.jinja" import common with context %}
{%- set node = grains.get('nodename')  %}
{%- set sa_key = 'sa.key'  %}
{%- set sa_crt = 'sa.crt'  %}

sa.working.dir:
  file.directory:
    - name: {{common.certs_path}}

sa.generate_private_key:
  cmd.run:
    - name: openssl genrsa -out {{common.certs_path}}/{{sa_key}} 2048
    #- unless: test -e {{common.certs_path}}/{{sa_key}}

sa.csr.conf:
  file.managed:
    - name: {{common.certs_path}}/csr.conf
    - source: salt://kubernetes/master/certificates/files/csr.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - defaults:
      O: {{common.cluster_name}}
      CN: service-accounts

sa.generate_request:
  cmd.run:
    - name: openssl req -new -key {{common.certs_path}}/{{sa_key}} -out {{common.certs_path}}/server.csr -config {{common.certs_path}}/csr.conf
   # - unless: test -e {{common.certs_path}}/server.csr

sa.generate_signed_crt:
  cmd.run:
    - name: openssl x509 -req -in {{common.certs_path}}/server.csr -CA {{common.ca_crt}} -CAkey {{common.ca_key}} -CAcreateserial -out {{common.certs_path}}/{{sa_crt}} -days 10000 -extensions v3_ext -extfile {{common.certs_path}}/csr.conf
    #- unless: test -e {{common.certs_path}}/{{sa_crt}}
