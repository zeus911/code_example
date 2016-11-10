# salt-run state.orchestrate my_orchestration pillar='{p1: value1,p2: value2}'
# salt-run state.orchestrate  mustang pillar='{"image_uuid": "13f711f4-499f-11e6-8ea6-2b9fb858a619","alias": "auto-created-by-salt", "hostname": "wu"}'
#salt ocp09.thu.briphant.com state.sls_id create_dataset_test_lx_vm create_smartos_vm -t 120
#salt-run manage.down removekeys=True

set_authorized_keys:
  salt.function:
    - tgt: 'datasets.dsapid,dsapid_server_thinkpad,centos7-qinghua,ocp09.thu.briphant.com,dataset_test_kvm,fifo-thinkpad.thinkpad'
    - tgt_type: list    
    - name: state.sls
    - arg:
      - set_ssh_authorized_keys
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
      - salt: set_authorized_keys


      
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
      - salt: set_authorized_keys
      
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
      - salt: set_authorized_keys


      
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
      - salt: set_authorized_keys
      
{% endif %} 

{% if module_property.type == "lx-os-dataset-not-include-custem-programm" and module_property.salt_target != "no-minion" %}
 

{{ module }}_vm_ping:
  salt.function:
    - tgt: 'dataset_test_kvm'
    - name: test.ping
    - timeout: 720 

      
{{ module }}_install_package:
  salt.function:
    - tgt: 'dataset_test_kvm'
    - name: state.sls_id
    - arg:
      - dataset_install_{{ module }} 
      - config_smartos_vm 
    - timeout: 3600
    - require:
      - salt: {{ module }}_vm_ping
      - salt: set_authorized_keys    

{{ module }}_prepare_dataset:
  salt.function:
    - tgt: '{{ module_property.salt_target }}'
    - name: state.sls_id
    - arg:
      - {{ module }}_generate_dataset_file
      - prepare_dataset 
    - timeout: 3600
    - require:
      - salt: {{ module }}_install_package

      
{{ module }}_create_lx_dataset:
  salt.function:
    - tgt: '{{ module_property.salt_target }}'
    - name: state.sls_id
    - arg:
      - upload_repository_{{ module }}
      - generate_dataset   
    - timeout: 7200
    - require:
      - salt: {{ module }}_prepare_dataset
      - salt: set_authorized_keys    
    
{% endif %} 
{% if module_property.type == "zvol" and module_property.salt_target != "no-minion" %}
 

{{ module }}_vm_ping:
  salt.function:
    - tgt: 'dataset_test_kvm'
    - name: test.ping
    - timeout: 720 

  

            
      
{% endif %} 
{% endfor %}
