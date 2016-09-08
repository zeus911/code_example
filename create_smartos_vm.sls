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
             "max_physical_memory": 1048,
             "quota": 50,
             "resolvers": ["114.114.114.114", "8.8.4.4"],
             "nics": [
                {
                  "nic_tag": "admin",
                  "ips": ["dhcp"]
                }
             ],
             "internal_metadata": {
              "root_pw": "root",
              "admin_pw": "admin"
              }
            }
            EOF
			
            vmadm  create -f /opt/smartos_vm.json

		 
