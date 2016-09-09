#salt   smartos-x230.zhixiang   state.sls create_smartos_vm  pillar='{"image_uuid": "13f711f4-499f-11e6-8ea6-2b9fb858a619","alias": "auto-created-by-salt", "hostname": "wu"}'    --log-level=debug -t 120
#salt   ocp09.thu.briphant.com   state.sls create_smartos_vm  pillar='{"image_uuid": "13f711f4-499f-11e6-8ea6-2b9fb858a619","alias": "wujunrong-salt-atuo-created", "hostname": "wu-test-qinghua"}'    --log-level=debug -t 120
#salt-ssh -i samrtos-dataset state.sls config_smartos_vm

/opt/smartos_vm.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - contents: |
            tee /opt/smartos_vm.json <<-'EOF'            
            {
             "brand": "joyent",
             "image_uuid": "{{ pillar['image_uuid'] }}",
             "alias": "{{ pillar['alias'] }}",
             "hostname": "{{ pillar['hostname'] }}",
             "max_physical_memory": 1024,
             "quota": 50,
             "resolvers": ["114.114.114.114", "8.8.4.4"],
             "nics": [
                {
                   "nic_tag": "admin",
                   "ip": "10.75.1.60",
                   "netmask": "255.255.255.0",
                   "gateway": "10.75.1.1",
                   "primary": true
                }
             ],
             "internal_metadata": {
              "root_pw": "root",
              "admin_pw": "admin"
              },
             "customer_metadata": {
                 "user-script" : "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
              }
            }			

            EOF
            vmadm  create -f /opt/smartos_vm.json
create_vm:
  cmd.script:
    - name: /opt/smartos_vm.sh
    - timeout: 1200
#    - onchanges:
#      - file: /opt/smartos_vm.sh
    - require:
         - file: /opt/smartos_vm.sh

