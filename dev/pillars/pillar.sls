kubernetes:
  etcd_cluster:
    docker_image: quay.io/coreos/etcd:v3.1.0
    load_balancer: 10.10.1.6
    nodes:
      - 10.10.1.6
  masters:
    schedulable: false
    nodes:
      - 10.10.1.5
  workers:
    nodes:
      - 10.10.1.4
  common:
    cluster_name: kubcluster
    cluster_dns: 10.10.1.5
    cluster_cidr: 10.100.0.0/16
    version: 1.10.3
    docker_binaries: gcr.io/google-containers/hyperkube
    docker_engine_version: 18.03.0~ce-0~ubuntu
    ca_private_key: |
      -----BEGIN RSA PRIVATE KEY-----
      MIIEpAIBAAKCAQEAx/eXKnPfh8lyce9Ix2881tIY2PMQLRtvf185VYceyBuAS3vW
      tcC+WI1LTXd0egWpZPKtAT5X83GQNYt2a/WOHSO7RTErMWiXZmHLyYC01Sp1hJFo
      b1SKWHkH4xbISghjJiYYh8qbUYfWzN7bJF+iK1eldJ2KJU89stV+eYhuiP0V3dPY
      iQ/hbFbZBD1IFExzgeTiLY/xLCBROQ4H5FDtE2TVznfT7ge/6mI0f8cRjA/kqiGd
      6qBk2ndOkLClYancxtcv6H/gHgzjcUDigqOGcS3Qb0tK3iPIDVieyrjLxhV5U/6x
      4F7pIEAEjy9aogcjcNMz3vdQlhjjVnmIzAnbJQIDAQABAoIBAQCeo3VxYGu9Nbtt
      V//M+Bqz8gl0U6BJqLJTwh+iEogBCJBHUf+MQVTAu5c55cKp60PvqfZGPkdYAof9
      cp6IF06fH3G5+r/herBhsMQTH+BWHFEO0qyfZdo7RglTxwcudGj0ItTjJYECtVlb
      PpFr0dK9v9KrKTAnWS4Bag3kLLBES9y9GKeMaJ2ntFT3xSI5d0PNQF4yM6a1aKvX
      8RCsU0wmJqjOxKoS2BRYJaVXLiM5Lui2S+lgRon04JEf8v/GweECg/nAk44juPFh
      PBxrt9t95jKbbWAbnFke4YbT2Gjtypp4PlI0VnRKJz/bH5GOT4+vlQoy3I/VATEH
      CF74nJABAoGBAOWVnWm+HiyP5uKEeDtEFVkDvhxJx9VOO1G8pB3IqOUAPKGxSIjo
      AzTx/s+nJSTfEDQLAojd+Tp9wRc/Jce1CAHt8Qu+vh0FktN9E4axtm8nmWGMsMEY
      8D1Mpy25YL1/+jBWeRIkIAbd+Y5RZ+ZjyjhGhPd6/qMlHhBE2dAvjSelAoGBAN75
      mgdoHLYAeFSBI1dtGdmD693x39thB3VrLQNy90iCxsGUHh1VLrHjG4SwhAPhVqe7
      qCnTu9+9SQj0AjiUUe6ts8dqQK9nYX8ur0fYi/8w/eEmRuT0cr2hKuT30pOewfIe
      r120Fqmw3ei9A4qMdlwuaxm6Kg9l8gK6/zbGV42BAoGAT17PIdyBUASb3JnReyPJ
      gZGiquLy/BJkvZhK4KUbhrfzPi8tFW+olChJYH63f6zCTEu2H50l6YvKMoA5TnaO
      gyRAnj/eN+hSX10xX/KWUI1PIINkJA28GGUkstEQ2dKhqw5qItRsYhNhkEsicWr0
      YUo389sIp1xQrW0wJCIcWaUCgYEA3DEjQbM3vyfhrJnGm9x6zYnwUEI+rbc5FWRc
      lG5g8vNqcdnij1cCgNrk3vkttWM/Hu87VuroOkADstq8osEd1BUnV4N/E3iFGIKy
      x8F6Ju1rmX8iPZGFCezxniF5ixwZLQ/OYDuqsbKewep+Z8DkVY3laAem54PmJXoi
      9CWUaoECgYBbj/EqMNYbPj1WfKYjTtrpp3EJfAjKHMqZachwR3dyylKq8aFBCe/z
      DOImsUoFxl5niZUZ7WPA64mioNfqSGcPOfDfj/cfA2axpltjdiMSXC1kg86wzMPj
      mNtSMbdl5bVirnsCB0adHehqmhsP/4HTSGySoUfXgQ+xTuOXA6aH6Q==
      -----END RSA PRIVATE KEY-----
    ca_certificate: |
      -----BEGIN CERTIFICATE-----
      MIIC/TCCAeWgAwIBAgIJAKrICd8z3lrpMA0GCSqGSIb3DQEBCwUAMBUxEzARBgNV
      BAMMCmt1YmNsdXN0ZXIwHhcNMTgwODE2MDkwMDUzWhcNNDYwMTAxMDkwMDUzWjAV
      MRMwEQYDVQQDDAprdWJjbHVzdGVyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
      CgKCAQEAx/eXKnPfh8lyce9Ix2881tIY2PMQLRtvf185VYceyBuAS3vWtcC+WI1L
      TXd0egWpZPKtAT5X83GQNYt2a/WOHSO7RTErMWiXZmHLyYC01Sp1hJFob1SKWHkH
      4xbISghjJiYYh8qbUYfWzN7bJF+iK1eldJ2KJU89stV+eYhuiP0V3dPYiQ/hbFbZ
      BD1IFExzgeTiLY/xLCBROQ4H5FDtE2TVznfT7ge/6mI0f8cRjA/kqiGd6qBk2ndO
      kLClYancxtcv6H/gHgzjcUDigqOGcS3Qb0tK3iPIDVieyrjLxhV5U/6x4F7pIEAE
      jy9aogcjcNMz3vdQlhjjVnmIzAnbJQIDAQABo1AwTjAdBgNVHQ4EFgQUoc2XRsv3
      LvaHnFAZqGp27K1rSW4wHwYDVR0jBBgwFoAUoc2XRsv3LvaHnFAZqGp27K1rSW4w
      DAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEAPyXP4lEP5gOPXdDI+waa
      yx8pj5vD6Ub5O/6EzdctnAWJ7atbxFFsRgdMd8XeV2CePORxECsk8p6UdyU70Gqf
      mUzgqjSXAHymSs7qidqkCu8CPoNSTYkjmLvcYWCcVNoYz7dclFSTLdlR6opzB5bf
      z8aQK/mt0aR0qSm6d5zqQ5GFTEYXklhSSuAnCCKNGJ1z3uHjkNR0t/BSZP50vYH8
      F6vxpXk+XQpBCY9Uc2aA/jwwDHBTgdf8MOjqDHtWU3SBtTQhCUpocb5jYA7sB/Zu
      U5gfi+b7N49qwV2ti6OoiuLR0MLzTiMo5mejlQMA1BFJ9XK26VzMUIG2vcHhKEsG
      bA==
      -----END CERTIFICATE-----
