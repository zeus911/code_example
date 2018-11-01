     
     #setup server
     #sudo cp /etc/zabbix/zabbix_agentd.conf.bak /etc/zabbix/zabbix_agentd.conf
     
     ServerIP=$1
     sudo sed -i.bak "s/Server=127.0.0.1/Server=$ServerIP/" /etc/zabbix/zabbix_agentd.conf
     grep "Server=" /etc/zabbix/zabbix_agentd.conf
     #sudo service zabbix-agent restart
     
     #auto register,auto register use active mode
     sudo sed -i "s/ServerActive=127.0.0.1/ServerActive=$ServerIP/" /etc/zabbix/zabbix_agentd.conf
     grep "ServerActive=" /etc/zabbix/zabbix_agentd.conf
     #sudo service zabbix-agent restart

     #auto register,set hostname
     sudo sed -i -e 's/Hostname=Zabbix server/#Hostname=Zabbix server/'  -e  's/# HostnameItem=system.hostname/HostnameItem=system.hostname/'  /etc/zabbix/zabbix_agentd.conf
     grep "Hostname=Zabbix" /etc/zabbix/zabbix_agentd.conf
     grep "HostnameItem="  /etc/zabbix/zabbix_agentd.conf
     sudo service zabbix-agent restart
