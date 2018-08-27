{%- from "kubernetes/map.jinja" import common with context %}
{%- set node = grains.get('nodename')  %}

kubectl.package:
  file.managed:
    - name: /usr/local/bin/kubectl
    - source: https://storage.googleapis.com/kubernetes-release/release/{{common.version}}/bin/linux/amd64/kubectl
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

kubeproxy.config:
  kubectl.kubeconfig_present:
    - ca_certificate: "{{common.ca_crt}}"
    - client_certificate: "{{common.certs_path}}/kubeproxy.crt"
    - client_key: "{{common.certs_path}}/kubeproxy.key"
    - username: "system:kube-proxy"
    - cluster_name: "{{common.cluster_name}}"
    - cluster_dns: "{{common.cluster_dns}}"
    - output_path: "{{common.config_path}}/kubeproxy.kubeconfig"

admin.config:
  kubectl.kubeconfig_present:
    - ca_certificate: "{{common.ca_crt}}"
    - client_certificate: "{{common.certs_path}}/admin.crt"
    - client_key: "{{common.certs_path}}/admin.key"
    - username: "admin"
    - cluster_name: "{{common.cluster_name}}"
    - cluster_dns: "{{common.cluster_dns}}"
    - output_path: "/root/.kube/config"
