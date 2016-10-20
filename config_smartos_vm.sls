

{% for module, module_property in salt['pillar.get']('dataset_repository', {}).items() %} 
{% if module_property.salt_target != "no-minion" %}
   
        {% if grains['os_family'] == 'Solaris' %}
            {% set vm_uuid_for_dataset     =  salt['cmd.run']('vmadm list | grep '~ module ~' | awk "{print \$1}"  ')  %}
        {% else %}
            {% set vm_uuid_for_dataset = 'xxxx' %}
        {% endif %}


        {% if module_property.type == 'zone-dataset' or module_property.type == 'lx-dataset' %}             
              {% set file_name_to_run        = '/zones/'+vm_uuid_for_dataset+'/root/root/'+module+'_install.sh' %} 
        {% elif module_property.type == 'zvol' %}
              {% set file_name_to_run        = '/root/'+module+'_install.sh' %}
              
centos-lx-brand-image-builder:
  file.recurse:
    - name: /root/centos-lx-brand-image-builder
    - source: salt://files/centos-lx-brand-image-builder
                      
        {% endif %}   

        
   {% for file_name, file_source in salt['pillar.get']('dataset_repository:'~ module ~':programm_files', {}).items() %} 
        {% if module_property.type == 'zone-dataset' or module_property.type == 'lx-dataset' %}
              {% set file_name_to_download   = '/zones/'+vm_uuid_for_dataset+'/root/root/'+file_name %} 
        {% elif module_property.type == 'zvol' %}
              {% set file_name_to_download   = '/root/'+file_name %} 
        {% endif %} 
download_{{ module }}_{{file_name }}_from_git:
  file.managed:
    - name: {{ file_name_to_download }}    
    - source: {{ file_source }}
    - user: root
    - group: root
    - mode: 755
    - source_hash: sha1={{ salt['cmd.run']('curl -s '~ file_source ~'  | openssl sha1 | cut -f 2 -d " " ' )  }}
    {% endfor %}   

generate_{{ module }}_script_file:
  file.managed:
    - name: {{ file_name_to_run }}
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - contents_pillar: dataset_repository:{{ module }}:dataset_install_script
    - require:
   {% for file_name, file_source in salt['pillar.get']('dataset_repository:'~ module ~':programm_files', {}).items() %} 
      - file: download_{{ module }}_{{file_name }}_from_git
   {% endfor %} 
   
dataset_install_{{ module }}:
  cmd.run:
    {% if module_property.type == 'zone-dataset' or module_property.type == 'lx-dataset' %}
    - name: |       
        echo in_cmd_run
        zlogin {{ vm_uuid_for_dataset }} /root/{{ module }}_install.sh >/dev/null
        scp  /zones/{{ vm_uuid_for_dataset }}/root/root/*.log  10.75.1.50:/var/www/html/log/
    {% elif module_property.type == 'zvol' %}
    - name: |       
        
        
        log_file_name=dataset_install_`date +%F-%H_%M`.log
        #exec &> "/root/$log_file_name" 
        echo in_cmd_run
        chmod +x /root/centos-lx-brand-image-builder/install
        chmod +x /root/centos-lx-brand-image-builder/guesttools/install.sh
        #/root/{{ module }}_install.sh >/dev/null
        
        {% set host_ip_dic = salt['mine.get']('*', 'network.interface_ip', 'glob') %}
        {% set ip4         = host_ip_dic[module_property.salt_target] %}
        #scp  /root/centos-lx-brand-image-builder/*.gz  {{ ip4 }}:/opt/centos-lx-brand-image-builder/
        ssh {{ ip4 }}  /opt/centos-lx-brand-image-builder/create-lx-image -t  /opt/centos-lx-brand-image-builder/test-lx-centos-7.2-20161020.tar.gz  -k 3.13.0 -m 20160117T201601Z -i test-lx-centos-7.2 -d "CentOS 7.2 64-bit lx-brand image." -u ttps://docs.joyent.com/images/container-native-linux;  
        
    {% endif %} 

    - timeout: 3600    
    - require:
      - file: generate_{{ module }}_script_file
    {% if module_property.type == 'zvol' %}
      - file: centos-lx-brand-image-builder
    {% endif %} 
{% endif %} 
{% endfor %} 
