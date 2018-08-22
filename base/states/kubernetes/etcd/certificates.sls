{%- from "kubernetes/map.jinja" import common with context %}
{%- set nodename = grains.get('nodename')  %}
{%- set etcd_key = 'etcd.key'  %}
{%- set etcd_crt = 'etcd.crt'  %}
{%- set etcd_csr = 'etcd.csr'  %}

generate_private_key:
  cmd.run:
    - name: openssl genrsa -out {{common.certs_path}}/{{etcd_key}} 2048
    - unless: test -e {{common.certs_path}}/{{etcd_key}}

csr.conf:
  file.managed:
    - name: {{common.certs_path}}/etcd_csr.conf
    - source: salt://kubernetes/common/files/csr.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - defaults:
      O: etcd-server
      CN: etcd-server

generate_request:
  cmd.run:
    - name: openssl req -new -key {{common.certs_path}}/{{etcd_key}} -out {{common.certs_path}}/{{etcd_csr}} -config {{common.certs_path}}/etcd_csr.conf
    - unless: test -e {{common.certs_path}}/etcd.csr

generate_signed_crt:
  cmd.run:
    - name: openssl x509 -req -in {{common.certs_path}}/{{etcd_csr}} -CA {{common.ca_crt}} -CAkey {{common.ca_key}} -CAcreateserial -out {{common.certs_path}}/{{etcd_crt}} -days 10000 -extensions v3_ext -extfile {{common.certs_path}}/etcd_csr.conf
    - unless: test -e {{common.certs_path}}/{{etcd_crt}}
