

{% for module, module_property in salt['pillar.get']('dataset_repository', {}).items() %} 
{% if module_property.type == 'zone-dataset' %}

   {% set vm_uuid_for_dataset     =  salt['cmd.run']('vmadm list | grep '~ module ~' | awk "{print \$1}"  ')  %}
   
   {% for file_name, file_source in salt['pillar.get']('dataset_repository:'~ module ~':programm_files', {}).items() %} 
/zones/{{ vm_uuid_for_dataset }}/root/root/{{file_name }}:
  file.managed:
    - source: {{ file_source }}
    - user: root
    - group: root
    - mode: 755
    - source_hash: sha1={{ salt['cmd.run']('curl -s '~ file_source ~'  | openssl sha1 | cut -f 2 -d " " ' )  }}
    {% endfor %}   

generate_{{ module }}_script_file:
  file.managed:
    - name: /zones/{{ vm_uuid_for_dataset }}/root/root/{{ module }}_install.sh
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - contents_pillar: dataset_repository:{{ module }}:dataset_install_script
    - require:
   {% for file_name, file_source in salt['pillar.get']('dataset_repository:'~ module ~':programm_files', {}).items() %} 
      - file: /zones/{{ vm_uuid_for_dataset }}/root/root/{{file_name }}
   {% endfor %} 
   
dataset_install_{{ module }}:
  cmd.run:
    - name: |       
        echo in_cmd_run
        zlogin {{ vm_uuid_for_dataset }} /root/{{ module }}_install.sh >/dev/null
        scp  /zones/{{ vm_uuid_for_dataset }}/root/root/*.log  10.75.1.50:/var/www/html/log/
    - timeout: 1800    
    - require:
      - file: generate_{{ module }}_script_file
{% endif %} 
{% endfor %} 
