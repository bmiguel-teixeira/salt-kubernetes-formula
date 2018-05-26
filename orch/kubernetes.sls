{%- set master_nodes = pillar['kubernetes']['masters']['minions'] %}
{%- set worker_nodes = pillar['kubernetes']['nodes']['minions'] %}
{%- set all_workers = (master_nodes + worker_nodes) | join(',') %}

setup.root_ca:
  salt.state:
    - sls: kubernetes.certificates.certificates_root
    - tgt: {{master_nodes[0]}}

copy_ca_key:
  cmd.run:
    - name: 'salt-cp {{ all_workers }} /var/cache/salt/master/minions/{{master_nodes[0]}}/files/srv/kubernetes/ca.key /srv/kubernetes'

copy_ca_crt:
  cmd.run:
    - name: 'salt-cp {{ all_workers }} /var/cache/salt/master/minions/{{master_nodes[0]}}/files/srv/kubernetes/ca.crt /srv/kubernetes'

#Generate certs
generate.certificates:
  salt.state:
    - sls: kubernetes.certificates.certificates
    - tgt: L@{{all_workers}}
    - tgt_type: compound


# Provision master nodes
#master_nodes:
#  salt.state:
#    - sls: kubernetes.master
#    - tgt: {{master_nodes | join(',')}}

#Generate certs
worker_nodes:
  salt.state:
    - sls: kubernetes.node
    - tgt: L@{{worker_nodes| join(',')}}
    - tgt_type: compound