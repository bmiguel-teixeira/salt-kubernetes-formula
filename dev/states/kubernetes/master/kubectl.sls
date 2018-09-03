{%- from "kubernetes/map.jinja" import common with context %}
{%- set node = grains.get('nodename')  %}

kubectl.working.dir:
  file.directory:
    - name: {{common.config_path}}

kubectl.package:
  file.managed:
    - name: /usr/local/bin/kubectl
    - source: https://storage.googleapis.com/kubernetes-release/release/v{{common.version}}/bin/linux/amd64/kubectl
    - skip_verify: true
    - mode: 744

kubelet.config:
  kubectl.kubeconfig_present:
    - ca_certificate: "{{common.ca_crt}}"
    - client_certificate: "{{common.certs_path}}/kubelet.crt"
    - client_key: "{{common.certs_path}}/kubelet.key"
    - username: "system:node:{{node}}"
    - cluster_name: "{{common.cluster_name}}"
    - cluster_dns: "{{common.cluster_dns}}"
    - output_path: "{{common.config_path}}/kubelet.kubeconfig"

controller.config:
  kubectl.kubeconfig_present:
    - ca_certificate: "{{common.ca_crt}}"
    - client_certificate: "{{common.certs_path}}/controller.crt"
    - client_key: "{{common.certs_path}}/controller.key"
    - username: "system:kube-controller-manager"
    - cluster_name: "{{common.cluster_name}}"
    - cluster_dns: "{{common.cluster_dns}}"
    - output_path: "{{common.config_path}}/controller.kubeconfig"

scheduler.config:
  kubectl.kubeconfig_present:
    - ca_certificate: "{{common.ca_crt}}"
    - client_certificate: "{{common.certs_path}}/scheduler.crt"
    - client_key: "{{common.certs_path}}/scheduler.key"
    - username: "system:kube-scheduler"
    - cluster_name: "{{common.cluster_name}}"
    - cluster_dns: "{{common.cluster_dns}}"
    - output_path: "{{common.config_path}}/scheduler.kubeconfig"

admin_user.working.dir:
  file.directory:
    - name: /root/.kube/

admin.config:
  kubectl.kubeconfig_present:
    - ca_certificate: "{{common.ca_crt}}"
    - client_certificate: "{{common.certs_path}}/admin.crt"
    - client_key: "{{common.certs_path}}/admin.key"
    - username: "admin"
    - cluster_name: "{{common.cluster_name}}"
    - cluster_dns: "{{common.cluster_dns}}"
    - output_path: "/root/.kube/config"
    - require:
      - admin_user.working.dir
