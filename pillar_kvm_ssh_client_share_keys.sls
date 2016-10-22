userdata:
  root:
    authorized_keys: |
       ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJJmmrR46ZQTp7T7/TVcYg1fverDWOntl4eO4HZEVJQdUJreW+hXXhwDpITazKkQx3ySoJ/zRhUMa9Wxl98OqCehThmMxTxz4084l/wiNU1456rKCBNSWYOGug9WDbEdCnVYB6wB6vo7/ymgBiXfXrGNeeA8iFZ5/LFdD8KXLBN3do8L+UdEdg8htM+qGG3JR2nTjnMQtKP7gzwTJS2VWXm9UQXlSt4Qko8zLlO0QnVTgiao9S94GzcNNHE1XAwytZlWYkYyCw8l6JquWSHAdSyRgfLpjfTLISqETheJDNIP7me9dMyl+8OhGZNwJfZavuRqnjwsGVhC4AwDTQGsdR root@smartos_thinkpad
       
       

mine_functions:
  test.ping: []
  network.ip_addrs: []
  grains.get:
    key: id
  say_hello:
    - mine_function: cmd.run 
    - echo hello   
  get_ssh_authorized_keys:
    - mine_function: cmd.run
    - cat /root/.ssh/id_rsa.pub
  public_ssh_hostname:
    - mine_function: grains.get
    - id