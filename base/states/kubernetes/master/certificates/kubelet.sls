{%- from "kubernetes/map.jinja" import common with context %}
{%- set node = grains.get('nodename')  %}
{%- set kubelet_key = 'kubelet.key'  %}
{%- set kubelet_crt = 'kubelet.crt'  %}
{%- set ip_address = salt['grains.get']('ip4_interfaces:eth0')[0]  %}

working.dir:
  file.directory:
    - name: "{{common.certs_path}}"

generate_private_key:
  x509.private_key_managed:
    - name: "{{common.certs_path}}/{{kubelet_key}}"
    - bits: 2048

generate_certificate:
  certificate.generate_and_sign_certificate:
    - ca_private_key: "{{common.ca_key}}"
    - ca_certificate: "{{common.ca_crt}}"
    - private_key: "{{common.certs_path}}/{{kubelet_key}}"
    - distinguished_names:
        O: "system:nodes"
        CN: "system:node:{{node}}"
    - subjectAltNames:
      - "DNS.1:kubernetes"
      - "DNS.2:{{node}}"
      - "IP.1:127.0.0.1"
      - "IP.2:{{ip_address}}"
    - output_path: "{{common.certs_path}}/{{kubelet_crt}}"