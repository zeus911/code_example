base:
  'ocp09.thu.briphant.com,smartos_thinkpad.zhixiang':
    - match: list
    - pillar_smartos_ssh_client_share_keys
    - pillar_smartos_ssh_server_share_keys
  'datasets.dsapid':
    - pillar_smartos_ssh_server_share_keys
    - match: list
  'centos7-qinghua':
    - pillar_kvm_ssh_server_share_keys
    - match: list
  'dataset_test_kvm':
    - pillar_kvm_ssh_client_share_keys
    - match: list    
  '*':
    - pillar_menifest_jason
    
    
    