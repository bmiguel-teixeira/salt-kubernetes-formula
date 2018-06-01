kubernetes:
  masters:
    schedulable: false
    minions:
      - kubm1
      - kubm2
  nodes:
    minions:
      - kubl1
      - kubl2
      - kubl3
      - kubl4
  common:
    cluster_name: kubcluster
    cluster_dns: 10.0.1.5
    cluster_cidr: 10.100.0.0/16
    version: v1.10.3
    docker_binaries: gcr.io/google-containers/hyperkube
    