kubernetes:
  common:
    cluster_dns: kubernetes.local
    masters:
      - master1
      - master2
      - master3
    nodes:
      - node1
      - node2
      - node3
    docker_base_binaries: gcr.io/google-containers/hyperkube:v1.10.0