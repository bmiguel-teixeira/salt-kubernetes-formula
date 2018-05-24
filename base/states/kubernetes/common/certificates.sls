{%- from "kubernetes/map.jinja" import common with context %}

dummy.working.dir:
  file.directory:
    - name: {{common.kubernetes_base_path}}

generate_ca_private_key:
  x509.private_key_managed:
    - name: {{common.ca_key}}
    - new: True

generate_ca_certificate:
  x509.certificate_managed:
    - name: {{common.ca_crt}}
    - signing_private_key: {{common.ca_key}}
    - CN: {{ common.cluster_dns }}
    - days_valid: 3650

generate_server_private_key:
  x509.private_key_managed:
    - name: {{common.api_server_key}}
    - new: True

generate_server_certificate:
  x509.certificate_managed:
    - name: {{common.api_server_crt}}
    - signing_private_key: {{common.ca_key}}
    - CN: {{ common.cluster_dns }}
    - days_valid: 3650