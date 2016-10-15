# salt-run state.orchestrate my_orchestration pillar='{p1: value1,p2: value2}'
# salt-run state.orchestrate  mustang pillar='{"image_uuid": "13f711f4-499f-11e6-8ea6-2b9fb858a619","alias": "auto-created-by-salt", "hostname": "wu"}'
#salt-run manage.down removekeys=True

ssh_key_dataset_server:
  salt.function:
    - tgt: 'datasets.dsapid'
    - name: state.sls
    - arg:
      - ssh_id_rsa
    - timeout: 60

ssh_key_log_server:
  salt.function:
    - tgt: 'centos7-qinghua'
    - name: state.sls
    - arg:
      - ssh_id_rsa
    - timeout: 60


{% for module, module_property in salt['pillar.get']('dataset_repository', {}).items() %} 
{% if module_property.type == "zone-dataset" and module_property.salt_target != "no-minion" %}
 
{{ module }}_create_nativezone:
  salt.function:
    - name: state.sls_id
    - tgt: '{{ module_property.salt_target }}'
    - arg:
      - create_{{ module }}_vm
      - create_smartos_vm   
    - timeout: 720

{{ module }}_vm_ping:
  salt.function:
    - tgt: '{{ module_property.salt_target }}'
    - name: test.ping
    - timeout: 720 
    - require:
      - salt: {{ module }}_create_nativezone
      
{{ module }}_install_package:
  salt.function:
    - tgt: '{{ module_property.salt_target }}'
    - name: state.sls_id
    - arg:
      - dataset_install_{{ module }} 
      - config_smartos_vm 
    - timeout: 3600
    - require:
      - salt: {{ module }}_vm_ping
      - salt: ssh_key_log_server


      
{{ module }}_create_mustang_dataset:
  salt.function:
    - tgt: '{{ module_property.salt_target }}'
    - name: state.sls_id
    - arg:
      - upload_repository_{{ module }}
      - generate_dataset   
    - timeout: 7200
    - require:
      - salt: {{ module }}_install_package
      - salt: ssh_key_dataset_server
      
{% endif %} 

{% if module_property.type == "lx-dataset" and module_property.salt_target != "no-minion" %}
 
{{ module }}_create_nativezone:
  salt.function:
    - name: state.sls_id
    - tgt: '{{ module_property.salt_target }}'
    - arg:
      - create_{{ module }}_vm
      - create_smartos_vm   
    - timeout: 720
{% endif %} 
{% endfor %}