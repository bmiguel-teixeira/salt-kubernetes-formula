{%- from "kubernetes/map.jinja" import common with context %}

start.kubelet:
  docker_container.running:
    - name: kubelet
    - image: "{{common.docker_binaries}}:v{{common.version}}"
    - network_mode: host
    - pid_mode: host
    - privileged: true
    - binds:
      - /sys:/sys:ro
      - /:/rootfs:ro
      - /var/lib/docker/:/var/lib/docker:rw
      - /var/lib/kubelet:/var/lib/kubelet:shared
      - {{common.config_path}}/:{{common.config_path}}
      - /var/run:/var/run:rw
      - {{common.manifests_path}}:{{common.manifests_path}}
    - command: "/hyperkube kubelet \
        --kubeconfig={{common.config_path}}/kubelet.kubeconfig \
        --address=0.0.0.0 \
        --allow-privileged=true \
        --enable-server \
        --enable-debugging-handlers \
        --pod-manifest-path={{common.manifests_path}} \
        --register-schedulable=true \
        --node-labels=role=node \
        --network-plugin=kubenet \
        --node-status-update-frequency=10s \
        --v=2 \
        --non-masquerade-cidr={{common.cluster_cidr}}"
