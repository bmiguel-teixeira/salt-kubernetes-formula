{%- set master_nodes = pillar['kubernetes']['masters']['minions'] %}
{%- set worker_nodes = pillar['kubernetes']['nodes']['minions'] %}
{%- set all_workers = (master_nodes + worker_nodes) | join(',') %}


#Download Images
setup.kubeket:
  salt.state:
    - sls: kubernetes.master.kubelet
    - tgt: {{master_nodes | join(',')}}

#Download Images
#setup.manifests:
#  salt.state:
#    - sls: kubernetes.master.manifests
#    - tgt: {{master_nodes | join(',')}}





