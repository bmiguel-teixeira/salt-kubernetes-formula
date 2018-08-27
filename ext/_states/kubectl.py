import logging
import os
from jinja2 import Template
import base64

log = logging.getLogger(__name__)


def __virtual__():
    return 'kubectl'

def kubeconfig_present(ca_certificate, client_certificate, client_key, username, cluster_name, cluster_dns, output_path):
    ret = {
        'name': 'kubeconfig_present',
        'changes': {},
        'result': False,
        'comment': '',
        'pchanges': {}
    }
    signing_cert = base64.b64encode(open(ca_certificate,"r").read())
    client_cert =  base64.b64encode(open(client_certificate,"r").read())
    client_key = base64.b64encode(open(client_key,"r").read())

    template = Template(kubectl_template).render(
        ca_certificate=signing_cert,
        client_certificate=client_cert,
        client_key=client_key,
        user=username,
        cluster_name=cluster_name,
        cluster_dns=cluster_dns
    )

    new_file = True
    if os.path.isfile(output_path):
        output_file =  open(output_path,"r").read()
        if output_file == template:
            new_file = False

    if new_file:
        output_file =  open(output_path,"w")
        output_file.write(template.encode("utf-8"))

        ret["result"] = True
        ret["comment"] = "kubeconfig created."
        ret['changes'] = {
            'old': 'No kubeconfig was found.',
            'new': 'New kubeconfig generated at [{kube}]'.format(kube=output_path)
        }
    else:
        ret["result"] = True
        ret["comment"] = "kubeconfig already in correct state."
    return ret

kubectl_template = '''
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: {{ca_certificate}}
    server: https://{{cluster_dns}}
  name: {{cluster_name}}
contexts:
- context:
    cluster: {{cluster_name}}
    user: {{user}}
  name: default
current-context: default
kind: Config
preferences: {}
users:
- name: {{user}}
  user:
    client-certificate-data: {{client_certificate}}
    client-key-data: {{client_key}}
'''
