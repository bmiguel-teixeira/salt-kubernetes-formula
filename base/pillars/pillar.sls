kubernetes:
  masters:
    schedulable: false
    minions:
      - KUBM
  nodes:
    minions:
      - kubl
  common:
    cluster_name: kubcluster
    cluster_dns: 192.168.1.84
    cluster_cidr: 10.100.0.0/16
    version: v1.10.0
    docker_binaries: gcr.io/google-containers/hyperkube
    