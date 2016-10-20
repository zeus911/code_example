{% set host_pubkey_dict = salt['mine.get']('*', 'get_ssh_authorized_keys', 'glob') %}
/root/.ssh/authorized_keys:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - contents: |
       {{ '' }} 
 {%- for host, keys in host_pubkey_dict|dictsort -%}
       {{ keys }}
       {{ '' }} 
 {%- endfor -%}
