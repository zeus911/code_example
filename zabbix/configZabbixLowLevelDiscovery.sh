

#monitor docker have sudo problem--sudo: no tty present and no askpass program specified problem,let zabbix have root right
#sudo sh -c  'echo "zabbix ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers' 
sudo cat /etc/sudoers

#monitor docker
           sudo bash -c "cat >/etc/zabbix/zabbix_agentd.d/low_level_discovery.conf" <<'EOF'
UserParameter=docker.discovery,sudo docker  stats --all  --no-stream | grep -v NAME | awk  -F "  +" 'BEGIN {print "data:"} {print   "-" , "\x27{#CONTAINERNAME}\x27:" , $2  }'|y2j
EOF

           sudo bash -c "cat >/etc/zabbix/zabbix_agentd.d/docker_items.conf" <<'EOF'
UserParameter=docker.item[*],sudo docker  stats --all  --no-stream | grep " $1 "  | awk  -F "  +" '{print  $$$2  }'| sed 's/%//g'       
EOF
            sudo service zabbix-agent restart
            zabbix_agentd -t docker.discovery
            zabbix_agentd -t docker.item[sdk,3] 




#monitor process
            sudo bash -c "cat >/etc/zabbix/zabbix_agentd.d/process_discovery.conf" <<'EOF'
UserParameter=process.discovery,ps -eo pid,%cpu,%mem,lstart,command --sort -%cpu | grep -v COMMAND| head -10|awk  'BEGIN {print "data:"}  {  print   "-" , "\x27{#PROCESSNAME}\x27:" , "\x27" $9,$10,$11 "\x27" ; print "  \x27{#PROCESSID}\x27:","\x27"$1"\x27" }'|y2j
EOF
          
    
            sudo bash -c "cat >/etc/zabbix/zabbix_agentd.d/process_items.conf" <<'EOF'
            UserParameter=process.item[*], ps aux | awk '{print $$2,$$3}' | grep "^$1 "| awk '{print $$2}'
EOF
            sudo service zabbix-agent restart
            zabbix_agentd -t process.discovery
 



