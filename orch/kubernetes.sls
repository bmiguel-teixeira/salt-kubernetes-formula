{%- set master_nodes = pillar['kubernetes']['masters']['minions'] %}
{%- set worker_nodes = pillar['kubernetes']['nodes']['minions'] %}
{%- set all_workers = (master_nodes + worker_nodes) | join(',') %}

setup.root_ca:
  salt.state:
    - sls: kubernetes.root_certificate
    - tgt: {{master_nodes[0]}}

copy_ca_key:
  cmd.run:
    - name: 'salt-cp --list {{ all_workers }} /var/cache/salt/master/minions/{{master_nodes[0]}}/files/etc/kubernetes/certs/ca.key etc/kubernetes/certs'

copy_ca_crt:
  cmd.run:
    - name: 'salt-cp --list {{ all_workers }} /var/cache/salt/master/minions/{{master_nodes[0]}}/files/etc/kubernetes/certs/ca.crt etc/kubernetes/certs'

# Provision master nodes
master_nodes:
  salt.state:
    - sls: kubernetes.master
    - tgt: L@{{master_nodes | join(',')}}
    - tgt_type: compound

#Generate certs
#worker_nodes:
#  salt.state:
#    - sls: kubernetes.node
#    - tgt: L@{{worker_nodes| join(',')}}
#    - tgt_type: compound