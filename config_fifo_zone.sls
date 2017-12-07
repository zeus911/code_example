

{% for fifo_module in 'snarl','sniffle','howl' %}

/data/{{fifo_module}}/etc/{{fifo_module}}.conf: 
  
   file.managed:
     - source: salt://file/{{fifo_module}}.conf.0.9.1
     - user: root
     - group: root
     - mode: 755
     - makedirs: True
     - template: jinja
     - backup: minion

{% endfor %}