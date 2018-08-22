{%- from "kubernetes/map.jinja" import common with context %}
{%- set etcd_key = 'etcd.key'  %}
{%- set etcd_crt = 'etcd.crt'  %}
{%- set etcd_csr = 'etcd.csr'  %}

certs.dir:
  file.directory:
    - name: {{common.certs_path}}

ca.cert:
  file.managed:
    - name: {{common.ca_crt}}
    - mode: 600
    - contents_pillar: kubernetes:common:ca_certificate

ca.key:
  file.managed:
    - name: {{common.ca_key}}
    - mode: 600
    - contents_pillar: kubernetes:common:ca_private_key