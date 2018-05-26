{%- from "kubernetes/map.jinja" import common with context %}

kubectl.package:
  file.managed:
    - name: /usr/local/bin/kubectl
    - source: https://storage.googleapis.com/kubernetes-release/release/{{common.version}}/bin/linux/amd64/kubectl
    - skip_verify: true
    - mode: 744

kubectl.config:
  cmd.run:
    - names: 
      - kubectl config set-cluster {{common.cluster_name}} --certificate-authority={{common.ca_crt}} --embed-certs=true --server=https://{{common.cluster_dns}}
      - kubectl config set-credentials 'user' --client-certificate={{common.api_server_crt}} --client-key={{common.api_server_key}} --embed-certs=true --token='token'
      - kubectl config set-context {{common.cluster_name}} --cluster={{common.cluster_name}} --user='user'
      - kubectl config use-context {{common.cluster_name}}
      - cp /root/.kube/config /var/lib/kubelet/kubeconfig