
{% for module, module_property in salt['pillar.get']('dataset_repository', {}).items() %}  
   {% if module_property.type == 'lx-dataset' %}           

   
{{ module }}_centos-lx-brand-image-builder:
  file.recurse:
    - name: /opt/centos-lx-brand-image-builder
    - source: salt://files/centos-lx-brand-image-builder
    
    
    

{{ module }}_generate_dataset_file:
  cmd.run:
    - name: |
    

    {% if module_property.type == 'lx-dataset' %} 
    
        {% set host_ip_dic = salt['mine.get']('*', 'network.interface_ip', 'glob') %}
        {% set kvm_server_ip         = host_ip_dic['dataset_test_kvm'] %}

        cd  /opt/centos-lx-brand-image-builder/;rm -f *.gz; rm -f *.json
        scp  {{ kvm_server_ip }}:/root/centos-lx-brand-image-builder/*.gz  /opt/centos-lx-brand-image-builder/
    
        log_file_name=prepare_dataset_`date +%F-%H_%M`.log
        exec &> "/opt/$log_file_name"     
        cd  /opt/centos-lx-brand-image-builder/; 
        chmod +x create-lx-image
        chmod +x create-manifest
        /opt/centos-lx-brand-image-builder/create-lx-image -t  `ls /opt/centos-lx-brand-image-builder/*.gz`  -k 3.13.0 -m 20160117T201601Z -i test-lx-centos-7.2 -d "CentOS 7.2 64-bit lx-brand image." -u https://docs.joyent.com/images/container-native-linux
 
    {% endif %}        
       
    - timeout: 3600    
    - require:  
       - file: {{ module }}_centos-lx-brand-image-builder

    
    
   {% endif %}  
{% endfor %}   