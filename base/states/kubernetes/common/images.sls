{%- from "kubernetes/map.jinja" import common with context %}

binary_image_present:
  docker_image.present:
    - name: {{common.docker_binaries}}:{{common.version}}