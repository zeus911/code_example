

mine_functions:
  test.ping: []
  cmd.run:
    cmd: echo {\"server\":\"`cat  /var/ssh/ssh_host_rsa_key.pub | cut -f -2 -d " "`\"  ,  \"client\":\"`cat /root/.ssh/id_rsa.pub 2>/dev/null`\"}|json
    python_shell: True  
  grains.get:
    key: id  
  network.ip_addrs: []
  network.interface_ip:
    iface: e1000g0