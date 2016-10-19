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
          "alias": "{{ module }}",
          "brand": "lx",
          "hostname": "{{ module }}",
          "kernel_version": "3.13.0",
          "max_physical_memory": 2048,
          "quota": 50,
          "image_uuid": "{{ module_property.image_uuid }}",
          "resolvers": ["172.17.1.10","114.114.114.114"],
          "nics": [
            {
              "nic_tag": "admin",
              "ip": "10.75.1.53",
              "netmask": "255.255.255.0",
              "gateway": "10.75.1.1",
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
{% if module_property.type == 'zvol' %}
/opt/{{ module }}_kvm_vm.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - contents: |
        tee /opt/centos-kvm.json <<-'EOF'
          {
            "alias": "{{ module }}",
            "brand": "kvm",
            "resolvers": [
              "172.17.1.10",
              "114.114.114.114"
            ],
            "ram": "2048",
            "vcpus": "2",
            "hostname": "{{ module }}",
            "nics": [
              {
                "nic_tag": "admin",
                "ip": "10.75.1.73",
                "netmask": "255.255.255.0",
                "gateway": "10.75.1.1",
                "model": "virtio",
                "primary": true
              }
             ],
            "internal_metadata": {
               "root_pw": "root",
               "admin_pw": "admin"
              },
            "customer_metadata" : {
                "user-script" : "sed -i.bak  's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; service sshd restart;  yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el7.noarch.rpm;echo 10.75.1.70 salt>>/etc/hosts;yum -y install salt-minion;service salt-minion start",            
                "root_authorized_keys":
                "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9vgaOMggb9WgG23YI7eHgx0H2MtI1jKfb1BfiLk5yXJpDVBJ+qH1f28YwIgzv9ig7Ul742NCXukOoAVaa4noiJmQhMQVMfE8P7jJm+gJ+zLP2MzxWetRGKAXx8NT+v34nSacvRlacoAoS/6AlHbsRvKWaO0XEGkFXSBciOl+28n8kmp9pAcblhHtJGKwRYgv7xN8KLWgrU2jD0s4vay3DpG4A8RbkTjosYgJRZzDHGqTEbjiFK7aS157pWcQlSANfDR2tH21DmYE5Pt2T4aGB9Mxo9sTUGytekk9BbssvnjZzoIO5FjtqX0/A5x8fvsfrLq2kh+rWUb8B5jdierRV root@frank"
              },
            "disks": [
              {
                "image_uuid": "{{ module_property.image_uuid }}",
                "boot": true,
                "model": "virtio"
              }
            ]
          }
        EOF
        vmadm  create -f /opt/centos-kvm.json
        sleep 600
create_{{ module }}_vm:
  cmd.script:
    - name: /opt/{{ module }}_kvm_vm.sh
    - timeout: 1200
    - require:
       - file: /opt/{{ module }}_kvm_vm.sh
{% endif %}
 
{% endfor %}   





