







'''
docker run \
    --volume=/dev:/dev \
    --volume=/sys:/sys:ro \
    --volume=/var/lib/docker/:/var/lib/docker:rw \
    --volume=/var/lib/kubelet/:/var/lib/kubelet:shared \
    --volume=/var/run:/var/run:rw \
    --volume=/etc/kubernetes:/etc/kubernetes:ro \
    --volume=/srv/kubernetes:/srv/kubernetes:ro \
    --net=host \
    --pid=host \
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
            --register-schedulable=true \
            --node-labels=role=node \
            --network-plugin=kubenet \
            --node-status-update-frequency=10s \
            --v=2 \
            --non-masquerade-cidr=10.100.0.0/16
'''