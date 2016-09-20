# salt-run state.orchestrate my_orchestration pillar='{p1: value1,p2: value2}'
# salt-run state.orchestrate  mustang pillar='{"image_uuid": "13f711f4-499f-11e6-8ea6-2b9fb858a619","alias": "auto-created-by-salt", "hostname": "wu"}'


install_nativezone:
  salt.function:
    - name: state.sls
    - tgt: 'fifo-test.zhixiang'
    - arg:
      - create_smartos_vm
    - timeout: 720
    - kwarg:
        pillar:
             image_uuid: "13f711f4-499f-11e6-8ea6-2b9fb858a619"
             alias: "auto-created-by-salt"
             hostname: "wu"            


        
create_mustang_dataset:
  salt.state:
    - tgt: 'fifo-test.zhixiang'
    - sls:
      - generate_dataset
    - timeout: 720
    - require:
      - salt: install_nativezone