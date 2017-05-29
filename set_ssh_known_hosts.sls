/root/.ssh/known_hosts:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - backup: minion
    - contents: |
         {{ '' }}       
         {#- Loop over targetted minions -#}
         {%- set host_keys = salt['mine.get']('*', 'cmd.run', expr_form='glob') -%}
         {%- set ips = salt['mine.get']('*', 'network.ip_addrs', expr_form='glob') -%}
         {%- for host, keys in host_keys|dictsort -%}
           {% set names = [] %}
           {%- set ip4 = ips[host] -%}
           {%- for ip in ip4 -%}
             {%- do names.append(ip) -%}
           {%- endfor -%}
 
           {%- set json_src = keys|load_json %}
           {%- set json_server = json_src.server %}          

           {%- for line in json_server.split('\n') -%}  
           {%- if line -%}
         {{ ','.join(names) }} {{ line }}
         {% endif -%}
           {%- endfor -%}
         {%- endfor -%}
