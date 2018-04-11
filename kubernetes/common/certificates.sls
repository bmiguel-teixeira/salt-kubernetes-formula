{%- from "kubernetes/map.jinja" import common with context %}

generate_private_key:
  x509.private_key_managed:
    - name: /home/cr4zypt/private.key
    - new: True

generate_ca_certificate:
  x509.certificate_managed:
    - name: /home/cr4zypt/certificate.crt
    - signing_private_key: /home/cr4zypt/private.key
    - CN: {{ common.cluster_dns }}
    - days_valid: 3650