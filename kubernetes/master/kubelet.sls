{%- from "kubernetes/map.jinja" import common with context %}

docker_container.running:
  - name: kubelet
  - image: {{ common.docker_base_binaries }}
  - network_mode: host
  - pid_mode: host
  - privileged: True
  - binds:
    - /etc/kubernetes/manifests:/etc/kubernetes/manifests
    - /var/lib/kubelet/:/var/lib/kubelet
    - /var/lib/docker/:/var/lib/docker
    - /var/run:/var/run





'''
docker run \

    --net=host \
    --privileged=true \
    --name=kubelet \
    -d \
    gcr.io/google-containers/hyperkube:v1.10.0 \
    /hyperkube kubelet \
            --kubeconfig=/var/lib/kubelet/kubeconfig \
            --address=0.0.0.0 \
            --allow-privileged=true \
            --enable-server \
            --enable-debugging-handlers \
            --pod-manifest-path=/etc/kubernetes/manifests \
            --register-schedulable=false \
            --node-labels=role=master \
            --network-plugin=kubenet \
            --node-status-update-frequency=10s \
            --v=2 \
            --non-masquerade-cidr=10.100.0.0/16
'''