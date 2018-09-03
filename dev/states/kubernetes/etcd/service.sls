{%- from "kubernetes/map.jinja" import common with context %}
{%- set image = salt.pillar.get('kubernetes:etcd_cluster:docker_image') %}
{%- set nodes = salt.pillar.get('kubernetes:etcd_cluster:nodes') %}
{%- set ip_address = salt['grains.get']('ip4_interfaces:eth0')[0]  %}

data.dir:
  file.directory:
    - name: {{common.etcd_data_path}}

start.etcd:
  docker_container.running:
    - name: etcd_node
    - image: {{image}}
    - network_mode: host
    - binds:
      - {{common.etcd_data_path}}:/var/lib/etcd/:rw,Z
      - {{common.certs_path}}:/etc/etcd/:rw,Z
    - command: "/usr/local/bin/etcd \
        --name {{ip_address}} \
        --cert-file=/etc/etcd/etcd.crt \
        --key-file=/etc/etcd/etcd.key \
        --peer-cert-file=/etc/etcd/etcd.crt \
        --peer-key-file=/etc/etcd/etcd.key \
        --trusted-ca-file=/etc/etcd/ca.crt \
        --peer-trusted-ca-file=/etc/etcd/ca.crt \
        --peer-client-cert-auth \
        --client-cert-auth \
        --initial-advertise-peer-urls=https://{{ip_address}}:2380 \
        --listen-peer-urls=https://0.0.0.0:2380 \
        --listen-client-urls=https://0.0.0.0:2379 \
        --advertise-client-urls=https://{{ip_address}}:2379 \
        --initial-cluster-token etcd-cluster-0 \
        --initial-cluster \
        {% for node in nodes -%} {{node}}=https://{{node}}:2380, {%- endfor %}  \
        --initial-cluster-state new \
        --data-dir=/var/lib/etcd"