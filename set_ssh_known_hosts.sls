/root/.ssh/known_hosts:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - contents: |
         {{ '' }}       
         {#- Loop over targetted minions -#}
         {%- set host_keys = salt['mine.get']('L@centos7-qinghua or L@datasets.dsapid', 'cmd.run', expr_form='compound') -%}
         {%- set ips = salt['mine.get']('L@centos7-qinghua or L@datasets.dsapid', 'network.ip_addrs', expr_form='compound') -%}
         {%- for host, keys in host_keys|dictsort -%}
           {% set names = [] %}
           {%- set ip4 = ips[host] -%}
           {%- for ip in ip4 -%}
             {%- do names.append(ip) -%}
           {%- endfor -%}
           
           {%- for line in keys.split('\n') -%}  
           {%- if line -%}
         {{ ','.join(names) }} {{ line }}
         {% endif -%}
           {%- endfor -%}
         {%- endfor -%}
