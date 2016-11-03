#salt-ssh -i samrtos-dataset state.sls config_smartos_vm


{% set distributed_cookie = salt['cmd.run']('openssl rand -base64 32 | fold -w16 | head -n1') %}
{% for module, module_property in salt['pillar.get']('dataset_repository', {}).items() %}  
{% if ( module_property.type == 'zone-dataset' or module_property.type == 'lx-dataset' ) and module_property.salt_target != "no-minion" %}


        {% if grains['os_family'] == 'Solaris' %}
            {% set vm_uuid_for_dataset     =  salt['cmd.run']('vmadm list | grep '~ module ~' | awk "{print \$1}"  ')  %}
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

{{ module }}_leo_manager_master:
  file.managed:
    - name: /zones/{{ vm_uuid_for_dataset }}/root/root/leo_manager.conf
    - source:
      - salt://files/leo_manager.conf.leofs_1
    - user: root
    - group: root
    - mode: 644

{{ module }}_leo_storage_master:
  file.managed:
    - name: /zones/{{ vm_uuid_for_dataset }}/root/root/leo_storage.conf
    - source:
      - salt://files/leo_storage.conf.leofs_1
    - user: root
    - group: root
    - mode: 644

{{ module }}_config_leofs_master:
  cmd.run:
    - name: |
        echo  abc
    {% if vm_uuid_for_dataset %}
    - require:
      
       - file: {{ module }}_leo_gateway_master
       - file: {{ module }}_leo_manager_master
       - file: {{ module }}_leo_storage_master
    {% endif %}


{{ module }}_leo_manager_slave:
  file.managed:
    - name: /zones/{{ vm_uuid_for_dataset }}/root/root/leo_manager.conf
    - source:
      - salt://files/leo_manager.conf.leofs_2
    - user: root
    - group: root
    - mode: 644       
       

       
       
{{ module }}_config_leofs_slave:
  cmd.run:
    - name: |
        echo  abc
    {% if vm_uuid_for_dataset %}
    - require: 
       - file: {{ module }}_leo_manager_slave
    {% endif %}       
       
{% endif %} 
{% endfor %}       
    
    
    
    