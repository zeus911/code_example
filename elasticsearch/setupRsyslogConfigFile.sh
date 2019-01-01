          sudo salt-ssh --sudo  --ignore-host-keys 'at-demo-orderer*'  state.sls    air-orderers-rsyslog 
          sudo salt-ssh --sudo  --ignore-host-keys  airtrac*-demo1  state.sls air-rsyslog
          ansible  'at-demo-orderer*' -m shell  -a " sudo systemctl restart rsyslog.service ;sleep 5; sudo systemctl status rsyslog.service "
          ansible  'airtrac*-demo1'   -m shell  -a " sudo systemctl restart rsyslog.service ;sleep 5; sudo systemctl status rsyslog.service "