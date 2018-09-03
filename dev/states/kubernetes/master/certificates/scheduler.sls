{%- from "kubernetes/map.jinja" import common with context %}
{%- set node = grains.get('nodename')  %}
{%- set key = 'scheduler.key'  %}
{%- set certificate = 'scheduler.crt'  %}
{%- set ip_address = salt['grains.get']('ip4_interfaces:eth0')[0]  %}

scheduler.generate.private.key:
  x509.private_key_managed:
    - name: "{{common.certs_path}}/{{key}}"
    - bits: 2048

gscheduler.enerate.certificate:
  certificate.generate_and_sign_certificate:
    - ca_private_key: "{{common.ca_key}}"
    - ca_certificate: "{{common.ca_crt}}"
    - private_key: "{{common.certs_path}}/{{key}}"
    - distinguished_names:
        O: "system:kube-scheduler"
        CN: "system:kube-scheduler"
    - subjectAltNames:
      - "DNS.1:kubernetes"
      - "DNS.2:{{node}}"
      - "IP.1:127.0.0.1"
      - "IP.2:{{ip_address}}"
    - output_path: "{{common.certs_path}}/{{certificate}}"
