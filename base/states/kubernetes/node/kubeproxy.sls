{%- from "kubernetes/map.jinja" import common with context %}
{%- set node = grains.get('nodename')  %}
{%- set proxy_key = 'kubeproxy.key'  %}
{%- set proxy_crt = 'kubeproxy.crt'  %}

proxy.working.dir:
  file.directory:
    - name: {{common.certs_path}}

proxy.generate_private_key:
  cmd.run:
    - name: openssl genrsa -out {{common.certs_path}}/{{proxy_key}} 2048
    #- unless: test -e {{common.certs_path}}/{{proxy_key}}

proxy.csr.conf:
  file.managed:
    - name: {{common.certs_path}}/csr.conf
    - source: salt://kubernetes/common/files/csr.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - defaults:
      CN: system:kube-proxy

proxy.generate_request:
  cmd.run:
    - name: openssl req -new -key {{common.certs_path}}/{{proxy_key}} -out {{common.certs_path}}/server.csr -config {{common.certs_path}}/csr.conf
    #- unless: test -e {{common.certs_path}}/server.csr

proxy.generate_signed_crt:
  cmd.run:
    - name: openssl x509 -req -in {{common.certs_path}}/server.csr -CA {{common.ca_crt}} -CAkey {{common.ca_key}} -CAcreateserial -out {{common.certs_path}}/{{proxy_crt}} -days 10000 -extensions v3_ext -extfile {{common.certs_path}}/csr.conf
    #- unless: test -e {{common.certs_path}}/{{proxy_crt}}


kubeproxy.svc:
  file.managed:
    - name: /etc/kubernetes/proxy.yml
    - source: salt://kubernetes/node/services/proxy.yml.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - defaults:
      image: {{common.docker_binaries}}:{{common.version}}