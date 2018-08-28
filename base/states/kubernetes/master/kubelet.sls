{%- from "kubernetes/map.jinja" import common with context %}
{%- set schedulable = salt.pillar.get('kubernetes:masters:schedulable') %}

kubelet_repo:
 pkgrepo.managed:
  - humanname: kubelet_engine
  - name: "deb http://apt.kubernetes.io/ kubernetes-xenial main"
  - dist: kubernetes-xenial
  - file:  /etc/apt/sources.list.d/kubernetes.list
  - gpgcheck: 1
  - key_url: https://packages.cloud.google.com/apt/doc/apt-key.gpg

kubelet_engine:
 pkg.installed:
  - name: kubelet
  - version: 1.10.3-00
  - refresh: True

kubelet.svc:
  file.managed:
    - name: /etc/systemd/system/kubelet.service
    - source: salt://kubernetes/master/files/services/kubelet.jinja
    - template: jinja
    - user: root
    - group: root
    - defaults:
        kubeconfig: {{common.config_path}}/kubelet.kubeconfig
        manifests_path: {{common.manifests_path}}
        schedulable: {{schedulable}}
        cidr: {{common.cluster_cidr}}