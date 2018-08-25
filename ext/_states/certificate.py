import logging
from OpenSSL.crypto import  *

log = logging.getLogger(__name__)


def __virtual__():
    return 'certificate'

def private_key_present():
    pass

def generate_and_sign_certificate(ca_private_key, ca_certificate, private_key, distinguished_names, subjectAltNames, output_path):
    ret = {
        'name': 'generate_and_sign_certificate',
        'changes': {},
        'result': False,
        'comment': '',
        'pchanges': {}
    }

    signing_pkey = load_privatekey(FILETYPE_PEM, open(ca_private_key,"r").read())
    signing_pcert = load_certificate(FILETYPE_PEM, open(ca_certificate,"r").read())

    client_pkey = load_privatekey(FILETYPE_PEM, open(private_key,"r").read())


    # Generate a certificate signing request
    certificate_request = X509Req()
    certificate_request.set_pubkey(client_pkey)

    certificate_request.get_subject().commonName = distinguished_names.get("CN")
    certificate_request.get_subject().organizationName = distinguished_names.get("O")

    extensions = []
    for ext in subjectAltNames:
        extensions.append(X509Extension(b"subjectAltName", False, ext.encode("utf-8")))
    extensions.append(X509Extension(b"authorityKeyIdentifier", False, "keyid".encode("utf-8"), issuer=signing_pcert))
    extensions.append(X509Extension(b"basicConstraints", False, "CA:FALSE".encode("utf-8")))
    extensions.append(X509Extension(b"keyUsage", False, "keyEncipherment, dataEncipherment".encode("utf-8")))
    extensions.append(X509Extension(b"extendedKeyUsage", False, "serverAuth, clientAuth".encode("utf-8")))


    certificate_request.add_extensions(extensions)

    # Sign the certificate
    certificate = X509()
    certificate.gmtime_adj_notBefore(0)
    certificate.gmtime_adj_notAfter(10 * 60 * 60 * 24 * 365) # 10 years
    certificate.set_issuer(signing_pcert.get_subject())
    certificate.set_subject(certificate_request.get_subject())
    certificate.set_pubkey(certificate_request.get_pubkey())
    certificate.add_extensions(certificate_request.get_extensions())
    certificate.sign(signing_pkey, "sha256")

    with open(output_path,"w") as my_cert:
        my_cert.write(dump_certificate(FILETYPE_PEM, certificate).decode("utf-8"))
        my_cert.close()

    ret["result"] = True
    return ret
