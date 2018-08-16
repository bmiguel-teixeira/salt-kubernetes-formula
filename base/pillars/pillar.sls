kubernetes:
  etcd_cluster:
    minions:
     - etcd00
  masters:
    schedulable: false
    minions:
      - kubm00
  nodes:
    minions:
      - kubl00
  common:
    cluster_name: kubcluster
    cluster_dns: 10.0.1.5
    cluster_cidr: 10.100.0.0/16
    version: v1.10.3
    docker_binaries: gcr.io/google-containers/hyperkube
