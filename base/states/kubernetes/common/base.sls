{%- from "kubernetes/map.jinja" import common with context %}

base.packages:
  pkg.installed:
    - pkgs: {{ common.pkgs }}

base.pips:
  pip.installed:
    - names: {{ common.pips}}