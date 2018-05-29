{%- from "kubernetes/map.jinja" import common with context %}
{%- set node = grains.get('nodename')  %}

kubectl.package:
  file.managed:
    - name: /usr/local/bin/kubectl
    - source: https://storage.googleapis.com/kubernetes-release/release/{{common.version}}/bin/linux/amd64/kubectl
    - skip_verify: true
    - mode: 744

kubelet.config:
  cmd.run:
    - names: 
      - kubectl config set-cluster {{common.cluster_name}} --certificate-authority={{common.ca_crt}} --embed-certs=true --server=https://{{common.cluster_dns}} --kubeconfig={{common.config_path}}/{{node}}.kubeconfig
      - kubectl config set-credentials system:node:{{node}} --client-certificate={{common.certs_path}}/kubelet.crt --client-key={{common.certs_path}}/kubelet.key  --embed-certs=true --kubeconfig={{common.config_path}}/{{node}}.kubeconfig
      - kubectl config set-context default --cluster={{common.cluster_name}} --user=system:node:{{node}} --kubeconfig={{common.config_path}}/{{node}}.kubeconfig
      - kubectl config use-context default --kubeconfig={{common.config_path}}/{{node}}.kubeconfig

#proxy.config:
#  cmd.run:
#    - names: 
#      - kubectl config set-cluster {{common.cluster_name}} --certificate-authority={{common.ca_crt}} --embed-certs=true --server=https://{{common.cluster_dns}} --kubeconfig={{common.config_path}}/{{node}}.kubeconfig
#      - kubectl config set-credentials system:node:{{node}} --client-certificate={{common.config_path}}/kubelet.crt --client-key={{common.config_path}}/kubelet.key  --embed-certs=true --kubeconfig={{common.config_path}}/{{node}}.kubeconfig
#      - kubectl config set-context default --cluster={{common.cluster_name}} --user=system:node:{{node}} --kubeconfig={{common.config_path}}/{{node}}.kubeconfig
#      - kubectl config use-context default --kubeconfig={{common.config_path}}/{{node}}.kubeconfig