{%- from "kubernetes/map.jinja" import common with context %}
{%- set node = grains.get('nodename')  %}

kubectl.working.dir:
  file.directory:
    - name: {{common.config_path}}


kubectl.package:
  file.managed:
    - name: /usr/local/bin/kubectl
    - source: https://storage.googleapis.com/kubernetes-release/release/{{common.version}}/bin/linux/amd64/kubectl
    - skip_verify: true
    - mode: 744

kubelet.config:
  cmd.run:
    - names: 
      - kubectl config set-cluster {{common.cluster_name}} --certificate-authority={{common.ca_crt}} --embed-certs=true --server=https://{{common.cluster_dns}} --kubeconfig={{common.config_path}}/kubelet.kubeconfig
      - kubectl config set-credentials system:node:{{node}} --client-certificate={{common.certs_path}}/kubelet.crt --client-key={{common.certs_path}}/kubelet.key  --embed-certs=true --kubeconfig={{common.config_path}}/kubelet.kubeconfig
      - kubectl config set-context default --cluster={{common.cluster_name}} --user=system:node:{{node}} --kubeconfig={{common.config_path}}/kubelet.kubeconfig
      - kubectl config use-context default --kubeconfig={{common.config_path}}/kubelet.kubeconfig


controller.config:
  cmd.run:
    - names: 
      - kubectl config set-cluster {{common.cluster_name}} --certificate-authority={{common.ca_crt}} --embed-certs=true --server=https://{{common.cluster_dns}} --kubeconfig={{common.config_path}}/controller.kubeconfig
      - kubectl config set-credentials system:node:{{node}} --client-certificate={{common.certs_path}}/controller.crt --client-key={{common.certs_path}}/controller.key  --embed-certs=true --kubeconfig={{common.config_path}}/controller.kubeconfig
      - kubectl config set-context default --cluster={{common.cluster_name}} --user=system:node:{{node}} --kubeconfig={{common.config_path}}/controller.kubeconfig
      - kubectl config use-context default --kubeconfig={{common.config_path}}/controller.kubeconfig




scheduler.config:
  cmd.run:
    - names: 
      - kubectl config set-cluster {{common.cluster_name}} --certificate-authority={{common.ca_crt}} --embed-certs=true --server=https://{{common.cluster_dns}} --kubeconfig={{common.config_path}}/scheduler.kubeconfig
      - kubectl config set-credentials system:node:{{node}} --client-certificate={{common.certs_path}}/scheduler.crt --client-key={{common.certs_path}}/scheduler.key  --embed-certs=true --kubeconfig={{common.config_path}}/scheduler.kubeconfig
      - kubectl config set-context default --cluster={{common.cluster_name}} --user=system:node:{{node}} --kubeconfig={{common.config_path}}/scheduler.kubeconfig
      - kubectl config use-context default --kubeconfig={{common.config_path}}/scheduler.kubeconfig


admin.config:
  cmd.run:
    - names: 
      - kubectl config set-cluster {{common.cluster_name}} --certificate-authority={{common.ca_crt}} --embed-certs=true --server=https://{{common.cluster_dns}} 
      - kubectl config set-credentials system:node:{{node}} --client-certificate={{common.certs_path}}/admin.crt --client-key={{common.certs_path}}/admin.key  --embed-certs=true
      - kubectl config set-context default --cluster={{common.cluster_name}} --user=system:node:{{node}} 
      - kubectl config use-context default 