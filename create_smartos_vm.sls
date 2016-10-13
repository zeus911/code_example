#salt   smartos-x230.zhixiang   state.sls create_smartos_vm  pillar='{"image_uuid": "13f711f4-499f-11e6-8ea6-2b9fb858a619","alias": "auto-created-by-salt", "hostname": "wu"}'    --log-level=debug -t 120
#salt   ocp09.thu.briphant.com   state.sls create_smartos_vm  pillar='{"image_uuid": "13f711f4-499f-11e6-8ea6-2b9fb858a619","alias": "wujunrong-salt-atuo-created", "hostname": "wu-test-qinghua"}'    --log-level=debug -t 120
#salt-ssh -i samrtos-dataset state.sls config_smartos_vm
#salt fifo-test.zhixiang environ.get mustang
{% for module, module_property in salt['pillar.get']('dataset_repository', {}).items() %} 

{% if module_property.type == 'zone-dataset' %}
/opt/{{ module }}_smartos_vm.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - contents: |
            set -e
            tee /opt/{{ module }}_smartos_vm.json <<-'EOF'            
            {
             "brand": "joyent",
             "image_uuid": "{{ module_property.image_uuid }}",
             "alias": "{{ module }}",
             "hostname": "{{ module }}",
             "max_physical_memory": 5120,
             "quota": 50,
             "resolvers": ["172.17.1.10", "114.114.114.114"],
             "nics": [
                {
                     "nic_tag": "admin",
                     "ips": ["dhcp"]
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
    - require:
       - file: /opt/{{ module }}_smartos_vm.sh
{% endif %}
 
{% if module_property.type == 'lx-dataset' %}
/opt/{{ module }}_LX_vm.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - contents: |
        tee /opt/centos7-docker.json <<-'EOF'
        {
          "alias": "docker-centos7-wujunrong",
          "brand": "lx",
          "hostname": "docker-centos7",
          "kernel_version": "3.13.0",
          "max_physical_memory": 2048,
          "quota": 10,
          "image_uuid": "07b33b7a-27a3-11e6-816f-df7d94eea009",
          "resolvers": ["114.114.114.114","8.8.4.4"],
          "nics": [
            {
              "nic_tag": "admin",
              "ip": "172.50.50.27",
              "netmask": "255.255.255.224",
              "gateway": "172.50.50.1",
              "primary": true
            }
          ]
        }
        EOF
        vmadm  create -f /opt/centos7-docker.json
create_{{ module }}_vm:
  cmd.script:
    - name: /opt/{{ module }}_LX_vm.sh
    - timeout: 1200
    - require:
       - file: /opt/{{ module }}_LX_vm.sh
{% endif %}

 
{% endfor %}   





