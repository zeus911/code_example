#salt   smartos-x230.zhixiang   state.sls create_smartos_vm  pillar='{"image_uuid": "13f711f4-499f-11e6-8ea6-2b9fb858a619","alias": "auto-created-by-salt", "hostname": "wu"}'    --log-level=debug -t 120
#salt   ocp09.thu.briphant.com   state.sls create_smartos_vm  pillar='{"image_uuid": "13f711f4-499f-11e6-8ea6-2b9fb858a619","alias": "wujunrong-salt-atuo-created", "hostname": "wu-test-qinghua"}'    --log-level=debug -t 120
#salt-ssh -i samrtos-dataset state.sls config_smartos_vm
#salt fifo-test.zhixiang environ.get mustang
{% for module, module_property in salt['pillar.get']('dataset_repository', {}).items() %} 

/opt/{{ module }}_smartos_vm.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - contents: |
            tee /opt/{{ module }}_smartos_vm.json <<-'EOF'            
            {
             "brand": "joyent",
             "image_uuid": "{{ module_property.image_uuid }}",
             "alias": "{{ module }}",
             "hostname": "{{ module }}",
             "max_physical_memory": 1024,
             "quota": 50,
             "resolvers": ["114.114.114.114", "172.17.1.10"],
             "nics": [
                {
                   "nic_tag": "admin",
                   "ip": "{{ module_property.ip }}",
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
                 "user-script" : "{{ module_property.customer_metadata }}"

              }
            }			
            EOF
            vmadm  create -f /opt/{{ module }}_smartos_vm.json
            export {{ module }}=`vmadm list | grep {{ module }} | awk '{print \$1}'`
            echo ${{ module }}

            

create_{{ module }}_vm:
  cmd.script:
    - name: /opt/{{ module }}_smartos_vm.sh
    - timeout: 1200
#    - onchanges:
#      - file: /opt/{{ module }}_smartos_vm.sh
    - require:
       - file: /opt/{{ module }}_smartos_vm.sh

       
{% endfor %}   





