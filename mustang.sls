# salt-run state.orchestrate my_orchestration pillar='{p1: value1,p2: value2}'
# salt-run state.orchestrate  mustang pillar='{"image_uuid": "13f711f4-499f-11e6-8ea6-2b9fb858a619","alias": "auto-created-by-salt", "hostname": "wu"}'
#salt-run manage.down removekeys=True


 
create_nativezone:
  salt.function:
    - name: state.sls
    - tgt: 'smartos-x230.zhixiang'
    - arg:
      - create_smartos_vm
    - timeout: 720

vm_ping:
  salt.function:
    - tgt: 'smartos-x230.zhixiang'
    - name: test.ping
    - timeout: 720
    - require:
      - salt: create_nativezone
      
install_package:
  salt.function:
    - tgt: 'smartos-x230.zhixiang'
    - name: state.sls
    - arg:
      - config_smartos_vm
    - timeout: 3600
    - require:
      - salt: vm_ping

dataset_key:
  salt.function:
    - tgt: 'datasets.dsapid'
    - name: state.sls
    - arg:
      - ssh_id_rsa
    - timeout: 720

      

#create_mustang_dataset:
#  salt.state:
#    - tgt: 'fifo-test.zhixiang'
#    - sls:
#      - generate_dataset
#    - timeout: 1720
#    - require:
#      - salt: install_package
#      - salt: dataset_key