{%- from "kubernetes/map.jinja" import common with context %}
{%- set node = grains.get('nodename')  %}
{%- set controller_key = 'controller.key'  %}
{%- set controller_crt = 'controller.crt'  %}

controller.working.dir:
  file.directory:
    - name: {{common.kubernetes_base_path}}/controller

controller.generate_private_key:
  cmd.run:
    - name: openssl genrsa -out {{common.kubernetes_base_path}}/controller/{{controller_key}} 2048
    #- unless: test -e {{common.kubernetes_base_path}}/{{controller_key}}

controller.csr.conf:
  file.managed:
    - name: {{common.kubernetes_base_path}}/csr.conf
    - source: salt://kubernetes/master/certificates/files/csr.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - defaults:
      O: system:kube-controller-manager
      CN: system:kube-controller-manager

controller.generate_request:
  cmd.run:
    - name: openssl req -new -key {{common.kubernetes_base_path}}/controller/{{controller_key}} -out {{common.kubernetes_base_path}}/server.csr -config {{common.kubernetes_base_path}}/csr.conf
    #- unless: test -e {{common.kubernetes_base_path}}/server.csr

controller.generate_signed_crt:
  cmd.run:
    - name: openssl x509 -req -in {{common.kubernetes_base_path}}/server.csr -CA {{common.ca_crt}} -CAkey {{common.ca_key}} -CAcreateserial -out {{common.kubernetes_base_path}}/controller/{{controller_crt}} -days 10000 -extensions v3_ext -extfile {{common.kubernetes_base_path}}/csr.conf
   # - unless: test -e {{common.kubernetes_base_path}}/controller/{{controller_crt}}
