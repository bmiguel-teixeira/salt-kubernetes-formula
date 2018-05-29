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
    cluster_dns: kubm1
    cluster_cidr: 10.100.0.0/16
    version: v1.10.3
    docker_binaries: gcr.io/google-containers/hyperkube
    