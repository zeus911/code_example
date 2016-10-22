userdata:
  root:
    authorized_keys: |
       ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJJmmrR46ZQTp7T7/TVcYg1fverDWOntl4eO4HZEVJQdUJreW+hXXhwDpITazKkQx3ySoJ/zRhUMa9Wxl98OqCehThmMxTxz4084l/wiNU1456rKCBNSWYOGug9WDbEdCnVYB6wB6vo7/ymgBiXfXrGNeeA8iFZ5/LFdD8KXLBN3do8L+UdEdg8htM+qGG3JR2nTjnMQtKP7gzwTJS2VWXm9UQXlSt4Qko8zLlO0QnVTgiao9S94GzcNNHE1XAwytZlWYkYyCw8l6JquWSHAdSyRgfLpjfTLISqETheJDNIP7me9dMyl+8OhGZNwJfZavuRqnjwsGVhC4AwDTQGsdR root@smartos_thinkpad
       
       

mine_functions:
  test.ping: []
  network.ip_addrs: []
  cmd.run:
    cmd: cat /etc/ssh/ssh_host_ecdsa_key.pub
    python_shell: True
  grains.get:
    key: id
  network.interface_ip:
    iface: eth0