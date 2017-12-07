#!/bin/bash
set -e
#salt    home-smartos.wu    cmd.script salt://script/chunter_install_salt.cmd.script.sh 
vmadm update $(vmadm list | grep wujunrong_salt |awk '{print $1}') <<EOF
 {     
     "add_nics": [

               {
                 "nic_tag": "storage",
                 "ip": "dhcp",
                 "primary": true
               }
            ]
  }
EOF
vmadm update $(vmadm list | grep wujunrong_salt |awk '{print $1}') <<EOF
 {     
     "update_nics": [
               {
                 "nic_tag": "admin",
                 "mac": "e2:aa:24:61:de:cb",
                 "ip": "10.0.1.38",
                 "netmask": "255.255.255.0",
                 "gateway": "10.0.1.1",
                 "model": "virtio",
                 "primary": true
               }
            ]
}
EOF
#echo '{"remove_nics": ["52:6a:68:66:a2:a0"]}' | vmadm update $(vmadm list | grep wujunrong_salt |awk '{print $1}')