{%- set host_pubkey_dict = salt['mine.get']('*', 'cmd.run', 'glob') -%}
/root/.ssh/authorized_keys:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - backup: minion
    - contents: |
       {{ '' }} 
 {%- for host, keys in host_pubkey_dict|dictsort -%}
       {%- set json_src = keys|load_json -%}
       {{ json_src.client }}
       {{ '' }} 
 {%- endfor -%}
