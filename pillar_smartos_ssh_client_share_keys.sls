

mine_functions:
  say_hello:
    - mine_function: cmd.run 
    - echo hello   
  shared_ssh_server_key_for_setting_ssh_authorized_keys:
    - mine_function: cmd.run
    - cat /root/.ssh/id_rsa.pub
  public_ssh_hostname:
    - mine_function: grains.get
    - id    
  network.interface_ip:
    iface: e1000g0