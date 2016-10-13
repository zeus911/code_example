base:
  '^((?!datasets.dsapid).)*$':
    - match: pcre
    - pillar_leofs_vm
    - pillar_menifest_jason
    - pillar_userdata
  'datasets.dsapid':
    - pillar_smartos_userdata
