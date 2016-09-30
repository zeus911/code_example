#/opt/local/etc/pkgin/repositories.conf:
#  file.managed:
#    - source: 
#      - salt://pkgin_repositories.conf
#    - user: root
#    - group: root
#    - mode: 644
#
#
#mustang_shell_script:
#  file.managed:
#    - name: /root/mustang.sh
#    - source: salt://mustang.sh
#    - user: root
#    - group: root
#    - mode: 755    
#    
#mustang_package:
#  file.managed:
#    - name: /root/mustang-Main.tar.gz
#    - source: salt://mustang-Main.tar.gz
#    - user: root
#    - group: root
#    - mode: 744 
#
#
#
#taurus_shell_script:
#  file.managed:
#    - name: /root/taurus.sh
#    - source: salt://taurus.sh
#    - user: root
#    - group: root
#    - mode: 755    
#    
#


{% for module, module_property in salt['pillar.get']('dataset_repository', {}).items() %} 
   {% set vm_uuid_for_dataset     =  salt['cmd.run']('vmadm list | grep '~ module ~' | awk "{print \$1}"  ')  %}
   {% for file_name, file_source in salt['pillar.get']('dataset_repository:'~ module ~':programm_files', {}).items() %} 
 
/zones/{{ vm_uuid_for_dataset }}/root/root/{{file_name }}:
  file.managed:
    - source: {{ file_source }}
    - user: root
    - group: root
    - mode: 755
    - source_hash: sha1={{ salt['cmd.run']('curl -s '~ file_source ~'  | openssl sha1 | cut -f 2 -d " " ' )  }}
    - require_in:
      - file: /zones/{{ vm_uuid_for_dataset }}/root/root/{{ module }}_install.sh
    {% endfor %}   

/zones/{{ vm_uuid_for_dataset }}/root/root/{{ module }}_install.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - contents_pillar: dataset_repository:{{ module }}:dataset_install_script
    - require_in:
      - cmd: dataset_install_{{ module }}
dataset_install_{{ module }}:
  cmd.run:
    - name: |       
        echo in_cmd_run
        zlogin {{ vm_uuid_for_dataset }} /root/{{ module }}_install.sh
        scp  /zones/{{ vm_uuid_for_dataset }}/root/root/*.log  10.75.1.50:/var/www/html/log/
    - timeout: 1800    
    

{% endfor %} 
