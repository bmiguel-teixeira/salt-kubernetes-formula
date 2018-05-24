{%- set master_nodes = pillar['kubernetes']['masters']['minions'] %}
{%- set worker_nodes = pillar['kubernetes']['nodes']['minions'] %}
{%- set all_workers = (master_nodes + worker_nodes) | join(',') %}

# Inital HealthCheck
health.check:
  salt.function:
    - name: test.ping
    - tgt: L@{{all_workers}}
    - tgt_type: compound

# Install base packages 
base.packages:
  salt.state:
    - sls: kubernetes.common.base
    - tgt: L@{{all_workers}}
    - tgt_type: compound

# Install docker 
docker.engine:
  salt.state:
    - sls: kubernetes.common.docker
    - tgt: L@{{all_workers}}
    - tgt_type: compound

#Download Images
download.packages:
  salt.state:
    - sls: kubernetes.common.kub_image
    - tgt: L@{{all_workers}}
    - tgt_type: compound

#Generate certs
generate.certificates:
  salt.state:
    - sls: kubernetes.common.certificates
    - tgt: L@{{all_workers}}
    - tgt_type: compound

#Download Images
setup.kubectl:
  salt.state:
    - sls: kubernetes.master.base
    - tgt: {{master_nodes | join(',')}}


#Download Images
setup.kubeket:
  salt.state:
    - sls: kubernetes.master.kubelet
    - tgt: {{master_nodes | join(',')}}

