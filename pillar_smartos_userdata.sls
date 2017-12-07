

mine_functions:
  test.ping: []
  cmd.run:
    cmd: cat /var/ssh/ssh_host_rsa_key.pub | cut -f -2 -d " "
    python_shell: True  
  grains.get:
    key: id  
  network.ip_addrs: []