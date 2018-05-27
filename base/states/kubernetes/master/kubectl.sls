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
      - kubectl config set-cluster {{common.cluster_name}} --certificate-authority={{common.ca_crt}} --embed-certs=true --server=https://{{common.cluster_dns}} --kubeconfig={{common.kubernetes_base_path}}/kubelet.kubeconfig
      - kubectl config set-credentials system:node:{{node}} --client-certificate={{common.kubernetes_base_path}}/kubelet.crt --client-key={{common.kubernetes_base_path}}/kubelet.key  --embed-certs=true --kubeconfig={{common.kubernetes_base_path}}/kubelet.kubeconfig
      - kubectl config set-context default --cluster={{common.cluster_name}} --user=system:node:{{node}} --kubeconfig={{common.kubernetes_base_path}}/kubelet.kubeconfig
      - kubectl config use-context default --kubeconfig={{common.kubernetes_base_path}}/kubelet.kubeconfig

controller.config:
  cmd.run:
    - names: 
      - kubectl config set-cluster {{common.cluster_name}} --certificate-authority={{common.ca_crt}} --embed-certs=true --server=https://{{common.cluster_dns}} --kubeconfig={{common.kubernetes_base_path}}/controller.kubeconfig
      - kubectl config set-credentials system:node:{{node}} --client-certificate={{common.kubernetes_base_path}}/controller/controller.crt --client-key={{common.kubernetes_base_path}}/controller/controller.key  --embed-certs=true --kubeconfig={{common.kubernetes_base_path}}/controller.kubeconfig
      - kubectl config set-context default --cluster={{common.cluster_name}} --user=system:node:{{node}} --kubeconfig={{common.kubernetes_base_path}}/controller.kubeconfig
      - kubectl config use-context default --kubeconfig={{common.kubernetes_base_path}}/controller.kubeconfig


scheduler.config:
  cmd.run:
    - names: 
      - kubectl config set-cluster {{common.cluster_name}} --certificate-authority={{common.ca_crt}} --embed-certs=true --server=https://{{common.cluster_dns}} --kubeconfig={{common.kubernetes_base_path}}/scheduler.kubeconfig
      - kubectl config set-credentials system:node:{{node}} --client-certificate={{common.kubernetes_base_path}}/scheduler/scheduler.crt --client-key={{common.kubernetes_base_path}}/scheduler/scheduler.key  --embed-certs=true --kubeconfig={{common.kubernetes_base_path}}/scheduler.kubeconfig
      - kubectl config set-context default --cluster={{common.cluster_name}} --user=system:node:{{node}} --kubeconfig={{common.kubernetes_base_path}}/scheduler.kubeconfig
      - kubectl config use-context default --kubeconfig={{common.kubernetes_base_path}}/scheduler.kubeconfig

admin.config:
  cmd.run:
    - names: 
      - kubectl config set-cluster {{common.cluster_name}} --certificate-authority={{common.ca_crt}} --embed-certs=true --server=https://{{common.cluster_dns}} 
      - kubectl config set-credentials system:node:{{node}} --client-certificate={{common.kubernetes_base_path}}/admin.crt --client-key={{common.kubernetes_base_path}}/admin.key  --embed-certs=true
      - kubectl config set-context default --cluster={{common.cluster_name}} --user=system:node:{{node}} 
      - kubectl config use-context default 