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
{% set vm_hostname = salt['cmd.run']("hostname") %}

{% for file_name, file_source in salt['pillar.get']('dataset_repository:'~ vm_hostname ~':programm_files', {}).items() %} 

/root/{{file_name }}:
  file.managed:
    - source: {{ file_source }}
    - user: root
    - group: root
    - mode: 755
    - source_hash: sha1={{ salt['cmd.run']('curl -s '~ file_source ~'  | openssl sha1 | cut -f 2 -d " " ' )  }}
    - require_in:
      - cmd: dataset_install
{% endfor %}   

dataset_install:
  cmd.run:
    - name: |
        {{ salt['pillar.get']('dataset_repository:'~ vm_hostname ~':dataset_install_script', {}) }}
    - timeout: 1200
    