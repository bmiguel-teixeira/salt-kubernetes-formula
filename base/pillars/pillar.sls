kubernetes:
  masters:
    schedulable: false
    minions:
      - kubm
  nodes:
    minions: []
  common:
    cluster_name: kubcluster
    cluster_dns: 192.168.1.78
    cluster_cidr: 10.100.0.0/16
    version: v1.10.0
    docker_binaries: gcr.io/google-containers/hyperkube
    