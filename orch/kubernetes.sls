{%- set master_nodes = pillar['kubernetes']['masters']['nodes'] %}
{%- set worker_nodes = pillar['kubernetes']['workers']['nodes'] %}
{%- set etcd_nodes = pillar['kubernetes']['etcd_cluster']['nodes'] %}
{%- set all_workers = (master_nodes + worker_nodes + etcd_nodes) %}

{% for worker in all_workers %}
common.state.{{worker}}:
 salt.state:
   - sls: kubernetes.common
   - tgt: S@{{worker}}
   - tgt_type: compound
{% endfor %} 

{% for etcd in etcd_nodes %}
etcd.cluster.{{etcd}}:
  salt.state:
    - sls: kubernetes.etcd
    - tgt: S@{{etcd}}
    - tgt_type: compound
{% endfor %} 

{% for master in master_nodes %}
master.nodes.{{ master }}:
  salt.state:
    - sls: kubernetes.master
    - tgt: S@{{ master }}
    - tgt_type: compound
{% endfor %} 

{% for worker in worker_nodes %}
worker.nodes.{{ worker }}:
  salt.state:
    - sls: kubernetes.node
    - tgt: S@{{ worker }}
    - tgt_type: compound
{% endfor %} 