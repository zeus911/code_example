   wget https://repo.zabbix.com/zabbix/4.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.0-2+xenial_all.deb
   sudo dpkg -i zabbix-release_4.0-2+xenial_all.deb
   sudo apt update
   sudo apt install -y zabbix-agent
   sudo service zabbix-agent start
   sudo systemctl enable zabbix-agent.service