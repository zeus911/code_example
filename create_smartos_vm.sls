#salt   smartos-x230.zhixiang   state.sls create_smartos_vm  pillar='{"image_uuid": "13f711f4-499f-11e6-8ea6-2b9fb858a619","alias": "auto-created-by-salt", "hostname": "wu"}'    --log-level=debug -t 120
#salt   ocp09.thu.briphant.com   state.sls create_smartos_vm  pillar='{"image_uuid": "13f711f4-499f-11e6-8ea6-2b9fb858a619","alias": "wujunrong-salt-atuo-created", "hostname": "wu-test-qinghua"}'    --log-level=debug -t 120
#salt-ssh -i samrtos-dataset state.sls config_smartos_vm
#salt fifo-test.zhixiang environ.get mustang
{% for module, module_property in salt['pillar.get']('dataset_repository', {}).items() %} 

{% if module_property.type == 'zone-dataset' and module_property.os == 'smartos' %}
/opt/{{ module }}_create_native_zone.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - contents: |
            set -e
            tee /opt/{{ module }}_native_zone.json <<-'EOF'            
            {
             "brand": "joyent",
             "image_uuid": "{{ module_property.image_uuid }}",
             "alias": "{{ module }}",
             "hostname": "{{ module_property.name }}",
             "max_physical_memory": {{ module_property.max_physical_memory }},
             "quota": 500,
             "resolvers": ["10.0.1.101", "114.114.114.114"],
             "nics": [
                {

                        "nic_tag": "admin",
                        "ip": "{{ module_property.ip }}",
                        "gateway": "{{ module_property.gateway }}",
                        "netmask": "255.255.255.0",
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
            vmadm  create -f /opt/{{ module }}_native_zone.json
            sleep 2
            echo export {{ module }}=`vmadm list | grep {{ module }} | awk '{print \$1}'`
            export {{ module }}=`vmadm list | grep {{ module }} | awk '{print \$1}'`
            echo ${{ module }}

            

create_{{ module }}_vm:
  cmd.script:
    - name: /opt/{{ module }}_create_native_zone.sh
    - timeout: 1200
    - require:
       - file: /opt/{{ module }}_create_native_zone.sh
{% endif %}
 
{% if module_property.type == 'lx-dataset' and module_property.os == 'linux' %}
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
          "internal_metadata": {
              "root_pw": "root",
              "admin_pw": "admin"
              },
          "customer_metadata": {
                 "user-script" : "{{ module_property.customer_metadata }}",
                 "root_authorized_keys": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9vgaOMggb9WgG23YI7eHgx0H2MtI1jKfb1BfiLk5yXJpDVBJ+qH1f28YwIgzv9ig7Ul742NCXukOoAVaa4noiJmQhMQVMfE8P7jJm+gJ+zLP2MzxWetRGKAXx8NT+v34nSacvRlacoAoS/6AlHbsRvKWaO0XEGkFXSBciOl+28n8kmp9pAcblhHtJGKwRYgv7xN8KLWgrU2jD0s4vay3DpG4A8RbkTjosYgJRZzDHGqTEbjiFK7aS157pWcQlSANfDR2tH21DmYE5Pt2T4aGB9Mxo9sTUGytekk9BbssvnjZzoIO5FjtqX0/A5x8fvsfrLq2kh+rWUb8B5jdierRV root@frank"
              },
          "nics": [
            {
              "nic_tag": "admin",
              "ip": "{{ module_property.ip }}",
              "netmask": "255.255.255.0",
              "gateway": "{{ module_property.gateway }}",
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
              "10.0.1.1",
              "114.114.114.114"
            ],
            "ram": "1024",
            "vcpus": "2",
            "hostname": "{{ module }}",
            "nics": [
              {
                "nic_tag": "admin",
                "ip": "{{ module_property.ip }}",
                "netmask": "255.255.255.0",
                "gateway": "{{ module_property.gateway }}",
                "model": "virtio",
                "primary": true
              }
             ],
            "internal_metadata": {
               "root_pw": "root",
               "admin_pw": "admin"
              },
            "customer_metadata" : {
                "user-script" : "{{ module_property.customer_metadata }}",            
                "root_authorized_keys":
                "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDGVztN1NgEp5WHWkfaCRvq8kvUPdlwRrfpSSyoBk9xi4q4yg/PP6C121YywYJtGRDdfwYXxTkY6qn6yAzvPyVYfeWvoEeEnnedyNQMGDSbz2mIpQRUH6ZI5Zdvopu6huuPa3K+OAYdVO4rgLLd9pYlpWIngbSZNVmC5loT+4HR5camrgTYF7mybowrXSCauOCjJTSaLhFBIdDS8Eh7m92dmrGcWLdf5xZaLLHkkzgFa3titMS9FUrvjL/gdg5qzCD7HezjJ//GXDzYn+z1+tStJ1DIa7YiXyoRHIqPB66jHVYfnMJ8UiDl1ENFLP9CbOkhsQg+SZuqQQvsWzAws0Lf Frank@Frank-PC"
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
        sleep 10
create_{{ module }}_vm:
  cmd.script:
    - name: /opt/{{ module }}_kvm_vm.sh
    - timeout: 1200
    - require:
       - file: /opt/{{ module }}_kvm_vm.sh

#centos-lx-brand-image-builder:
#  file.recurse:
#    - name: /root/centos-lx-brand-image-builder
#    - source: salt://files/centos-lx-brand-image-builder
          
       
{% endif %}
 
{% endfor %}   





