{%- set master_nodes = pillar['kubernetes']['masters']['minions'] %}
{%- set worker_nodes = pillar['kubernetes']['nodes']['minions'] %}
{%- set etcd_nodes = pillar['kubernetes']['etcd_cluster']['minions'] %}
{%- set all_workers = (master_nodes + worker_nodes + etcd_nodes) | join(',') %}

# common.state:
#  salt.state:
#    - sls: kubernetes.common
#    - tgt: L@{{all_workers}}
#    - tgt_type: compound

etcd.cluster:
  salt.state:
    - sls: kubernetes.etcd
    - tgt: L@{{ etcd_nodes | join(',') }}
    - tgt_type: compound

# Provision master nodes
# master_nodes:
#   salt.state:
#     - sls: kubernetes.master
#     - tgt: L@{{master_nodes | join(',')}}
#     - tgt_type: compound

#Generate certs
# worker_nodes:
#   salt.state:
#     - sls: kubernetes.node
#     - tgt: L@{{worker_nodes| join(',')}}
#     - tgt_type: compound