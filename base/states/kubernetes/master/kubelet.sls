{%- from "kubernetes/map.jinja" import common with context %}
{%- set schedulable = salt.pillar.get('kubernetes:masters:schedulable') %}
{%- set cluster_dns = salt.pillar.get('kubernetes:common:cluster_dns')  %}

#start.kubelet:
#  docker_container.running:
#    - name: kubelet
#    - image: {{common.docker_binaries}}:{{common.version}}
#    - network_mode: host
#    #- pid_mode: host
#    - privileged: true
#    - binds:
#      - /var/lib/docker/:/var/lib/docker:rw,Z
#      - /var/lib/kubelet/:/var/lib/kubelet:rw,Z
#      - /var/run:/var/run:rw,Z
#      - /etc/kubernetes:/etc/kubernetes:rw,Z
#    - command: /hyperkube kubelet \
#            --kubeconfig=/var/lib/kubelet/kubeconfig \
#            --address=0.0.0.0 \
#            --allow-privileged=true \
#            --enable-server \
#            --enable-debugging-handlers \
#            --pod-manifest-path={{ common.manifests_path }} \
#            --register-schedulable=false \
#            --node-labels=role=master \
#            --network-plugin=kubenet \
#            --node-status-update-frequency=10s \
#            --v=2 \
#            --non-masquerade-cidr={{common.cluster_cidr}}

clean:
  docker_container.absent:
    - name: kubelet
    - force: True

start.kubelet:
  cmd.run:
    - name: "docker run \
    --volume=/var/lib/docker/:/var/lib/docker:rw \
    --volume=/var/lib/kubelet/:/var/lib/kubelet:rw \
    --volume=/var/run:/var/run:rw \
    --volume={{common.manifests_path}}:/etc/kubernetes/manifests:rw \
    --net=host \
    --privileged=true \
    --name=kubelet \
    -d \
    {{common.docker_binaries}}:{{common.version}} \
    /hyperkube kubelet \
            --kubeconfig=/var/lib/kubelet/kubeconfig \
            --address=0.0.0.0 \
            --allow-privileged=true \
            --enable-server \
            --enable-debugging-handlers \
            --pod-manifest-path=/etc/kubernetes/manifests \
            --register-schedulable={{schedulable}} \
            --node-labels=role=master \
            --network-plugin=kubenet \
            --node-status-update-frequency=10s \
            --v=2 \
            --non-masquerade-cidr={{common.cluster_cidr}}"
