#salt ocp09.thu.briphant.com state.sls generate_dataset -t 720   pillar='{"dataset_repository.mustang.vm_uuid": "938c6024-0c37-e63e-9314-83437ac8ebe7"}' 
#zfs list -t    snapshot



{% for module, module_property in salt['pillar.get']('dataset_repository', {}).items() %}  

{% if ( module_property.type == 'zone-dataset' or module_property.type == 'lx-dataset' ) and module_property.salt_target != "no-minion" %}

{% set dataset_uuid = salt['cmd.run']("python -c 'import uuid; print uuid.uuid1()'") %}
{{ salt['cmd.run']('mkdir -p /var/tmp/'~ dataset_uuid ~'') }}
{% set snapshot    =  salt['cmd.run']("date -u '+%Y-%m-%dT%H:%M:%SZ' ") %}
{% set vm_uuid_for_dataset     =  salt['cmd.run']('vmadm list | grep '~ module ~' | awk "{print \$1}"  ')  %}

   {% if vm_uuid_for_dataset %}
     {{ salt['cmd.run']('zlogin '~ vm_uuid_for_dataset ~' sm-prepare-image -y 1>/dev/null 2>/dev/null') }}
     {{ salt['cmd.run']('zfs snapshot zones/'~ vm_uuid_for_dataset ~'@'~ module ~''~ snapshot ~'') }}
     {{ salt['cmd.run']('zfs send zones/'~ vm_uuid_for_dataset ~'@'~ module ~''~ snapshot ~' 2> /dev/null | gzip -9 > /var/tmp/'~ dataset_uuid ~'/'~ module_property.name ~'.zfs.gz') }}
   

/var/tmp/{{ dataset_uuid }}/manifest.json:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - makedirs : True
    - contents: |
       { 
        "v": 2,
        "uuid": "{{ dataset_uuid }}",
        "name": "{{ module_property.name }}{{ salt['cmd.run']("date +%FT%TZ") }}",
        "version": "{{ module_property.version }}" ,
        "owner": "00000000-0000-0000-0000-000000000000",
        "description": "{{ module_property.description }}",
        "os": "{{ module_property.os }}",
        "type": "{{ module_property.type }}",
        "urn": "{{ module_property.os }}:briphant:{{ module_property.name }}:{{ module_property.version }}",
        "creator_name": "briphant",
        "creator_uuid": "3b1ffc44-9e62-11e4-8e98-b760856b37ca",
        "vendor_uuid": "3b1ffc44-9e62-11e4-8e98-b760856b37ca",
        "created_at": "{{ salt['cmd.run']("date +%FT%TZ") }}",
        "published_at": "{{ salt['cmd.run']("date +%FT%TZ") }}",
        "state": "active",
        "public": true,
        "disabled": false,
        "zpool": "zones",      
        "files": [
            {
                "path": "{{ module_property.name }}.zfs.gz",
                "sha1": "{{ salt['cmd.run']('digest -a sha1 /var/tmp/'~ dataset_uuid ~'/'~ module_property.name ~'.zfs.gz') }}",
                "size": {{ salt['cmd.run']('ls -la  /var/tmp/'~ dataset_uuid ~'/'~ module_property.name ~'.zfs.gz | awk "{ print \$5}" ') }},
                "compression": "gzip"
            }
        ],
        "requirements": {
            "networks": [
                {
                    "name": "net0",
                    "description": "primary nic"
                }
            ]
        }
       }
       
       {% endif %}

    {% if module_property.type == 'lx-os-dataset-but-not-include-custem-programm' %}           

    
/opt/{{ module }}-update_lxzone_dataset_manifest_file.py:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - makedirs : True
    - contents: |
        #!/opt/local/bin/python
        import json
        
        sub_unit_file_dict = {
                    'path': '{{ salt['cmd.run']("cd  /opt/centos-lx-brand-image-builder;ls *.zfs.gz") }}',                                
                 }
        
        b_dict = {
                      'name': 'lx-zone_{{ module_property.name }}{{ salt['cmd.run']("date +%FT%TZ") }}',
                      'uuid': '{{ dataset_uuid }}',
                      "creator_uuid": "3b1ffc44-9e62-11e4-8e98-b760856b37ca",
                      "vendor_uuid": "3b1ffc44-9e62-11e4-8e98-b760856b37ca",
                      "created_at": "2016-10-17T02:03:37Z",
                      "state": "active",
                      "public": True,
                      "urn": "smartos:briphant:mustang-dataset:2.0"
                 }

        
        print "abc"
        with open('/opt/centos-lx-brand-image-builder/manifest.json') as f:
            data = json.load(f)
        
        data['files'][0].update(sub_unit_file_dict)
        data.update(b_dict)
        with open('/opt/centos-lx-brand-image-builder/manifest.json', 'w') as f:
            json.dump(data, f)

    {% endif %} 
upload_repository_{{ module }}:
  cmd.run:
    - name: |
        #zlogin {{ vm_uuid_for_dataset }}  hostname
    {% if module_property.type == 'lx-os-dataset-but-not-include-custem-programm' %} 
        log_file_name=upload_dataset_`date +%F-%H_%M`.log
        exec &> "/opt/$log_file_name"     

        cd  /opt/centos-lx-brand-image-builder
        mv `ls *.json`  manifest.json
        python /opt/{{ module }}-update_lxzone_dataset_manifest_file.py
        cp  *.json  *.zfs.gz /var/tmp/{{ dataset_uuid }}  
    {% endif %}        
       
        scp  -r /var/tmp/{{ dataset_uuid }}  root@10.75.1.75:/data/files
        ssh 10.75.1.75  chown  -R dsapid:dsapid /data/files/{{ dataset_uuid }}
        ssh 10.75.1.75  svcadm restart svc:/application/dsapid:default
    - timeout: 3600    
    - require:
       {% if vm_uuid_for_dataset %}
       - file: /var/tmp/{{ dataset_uuid }}/manifest.json 
       {% endif %}
    {% if module_property.type == 'lx-os-dataset-but-not-include-custem-programm' %}    
       - file: /opt/{{ module }}-update_lxzone_dataset_manifest_file.py
       
    {% endif %}  
{% endif %} 




{% endfor %}    
