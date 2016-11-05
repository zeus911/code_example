#salt-ssh -i samrtos-dataset state.sls config_smartos_vm



{% for module, module_property in salt['pillar.get']('dataset_repository', {}).items() %}  
{% if module_property.type == 'zone-dataset' and module_property.salt_target != "no-minion" %}


        {% if grains['os_family'] == 'Solaris' %}
            {% set vm_uuid_for_dataset     =  salt['cmd.run']('vmadm list | grep '~ module ~' | awk "{print \$1}"  ')  %}
            {% set distributed_cookie = salt['cmd.run']('zlogin '~ vm_uuid_for_dataset ~' openssl rand -base64 32 | fold -w16 | head -n1') %}
            
        {% else %}
            {% set vm_uuid_for_dataset = 'xxxx' %}
        {% endif %}


{{ module }}_leo_gateway_master:
  file.managed:
    - name: /zones/{{ vm_uuid_for_dataset }}/root/root/leo_gateway.conf
    - source:
      - salt://files/leo_gateway.conf.leofs_1
    - user: root
    - group: root
    - mode: 644
    
{{ module }}_config_leo_gateway_master:
  file.blockreplace:
    - name: /zones/{{ vm_uuid_for_dataset }}/root/root/leo_gateway.conf
    - marker_start: "## BLOCK TOP : added by wujunrong"
    - marker_end: "## BLOCK BOTTOM : added by wujunrong" 
    - content: |
            distributed_cookie = gg7WA4lTKIxFL/Kz
            
            managers = [manager_0@10.75.1.80, manager_1@10.75.1.81]
    - show_changes: True
    - append_if_not_found: True
    - backup: '.bak'
    {% if vm_uuid_for_dataset %}
    - require:
       - file: {{ module }}_leo_gateway_master
    {% endif %}


    

{{ module }}_leo_manager_master:
  file.managed:
    - name: /zones/{{ vm_uuid_for_dataset }}/root/root/leo_manager.conf
    - source:
      - salt://files/leo_manager.conf.leofs_1
    - user: root
    - group: root
    - mode: 644

{{ module }}_config_leo_manager_master:
  file.blockreplace:
    - name: /zones/{{ vm_uuid_for_dataset }}/root/root/leo_manager.conf
    - marker_start: "## BLOCK TOP : added by wujunrong"
    - marker_end: "## BLOCK BOTTOM : added by wujunrong" 
    - content: |            
            nodename = manager_0@10.75.1.80
            manager.mode = master
            distributed_cookie = gg7WA4lTKIxFL/Kz
            
            manager.partner = manager_1@10.75.1.81
            
    - show_changes: True
    - append_if_not_found: True
    - backup: '.bak'
    {% if vm_uuid_for_dataset %}
    - require:
       - file: {{ module }}_leo_manager_master
    {% endif %}    



    
{{ module }}_leo_storage_master:
  file.managed:
    - name: /zones/{{ vm_uuid_for_dataset }}/root/root/leo_storage.conf
    - source:
      - salt://files/leo_storage.conf.leofs_1
    - user: root
    - group: root
    - mode: 644
{{ module }}_config_leo_storage_master:
  file.blockreplace:
    - name: /zones/{{ vm_uuid_for_dataset }}/root/root/leo_storage.conf
    - marker_start: "## BLOCK TOP : added by wujunrong"
    - marker_end: "## BLOCK BOTTOM : added by wujunrong" 
    - content: |            

            distributed_cookie = gg7WA4lTKIxFL/Kz
            managers = [manager_0@10.75.1.80, manager_1@10.75.1.81]
            
    - show_changes: True
    - append_if_not_found: True
    - backup: '.bak'
    {% if vm_uuid_for_dataset %}
    - require:
       - file: {{ module }}_leo_storage_master
    {% endif %}        
    

{{ module }}_config_master:
  cmd.run:
    - name: |
        echo  abc
    {% if vm_uuid_for_dataset %}
    - require: 
       - file: {{ module }}_config_leo_storage_master
       - file: {{ module }}_config_leo_manager_master
       - file: {{ module }}_config_leo_gateway_master
    {% endif %}  


    
    
    
{{ module }}_leo_manager_slave:
  file.managed:
    - name: /zones/{{ vm_uuid_for_dataset }}/root/root/leo_manager.conf
    - source:
      - salt://files/leo_manager.conf.leofs_2
    - user: root
    - group: root
    - mode: 644       

{{ module }}_config_leo_manager_slave:
  file.blockreplace:
    - name: /zones/{{ vm_uuid_for_dataset }}/root/root/leo_manager.conf
    - marker_start: "## BLOCK TOP : added by wujunrong"
    - marker_end: "## BLOCK BOTTOM : added by wujunrong" 
    - content: |            

            nodename = manager_1@10.75.1.81
            manager.mode = slave
            distributed_cookie = gg7WA4lTKIxFL/Kz
            manager.partner = manager_0@10.75.1.80
            
    - show_changes: True
    - append_if_not_found: True
    - backup: '.bak'
    {% if vm_uuid_for_dataset %}
    - require:
       - file: {{ module }}_leo_manager_slave
    {% endif %}        


    
       
{{ module }}_config_slave:
  cmd.run:
    - name: |
        echo  abc
    {% if vm_uuid_for_dataset %}
    - require: 
       - file: {{ module }}_config_leo_manager_slave
    {% endif %}       
       
{% endif %} 
{% endfor %}       
    
    
    
    