#salt ocp09.thu.briphant.com state.sls generate_dataset -t 180

{% for module, module_property in salt['pillar.get']('dataset_repository', {}).items() %}  

{% set dataset_uuid = salt['cmd.run']("python -c 'import uuid; print uuid.uuid1()'") %}
{% set snapshot    =  salt['cmd.run']("date -u '+%Y-%m-%dT%H:%M:%SZ' ") %}
{{ salt['cmd.run']('zfs snapshot zones/'~ module_property.vm_uuid ~'@'~ module ~''~ snapshot ~'') }}
{{ salt['cmd.run']('mkdir -p /tmp/'~ dataset_uuid ~'') }}
{{ salt['cmd.run']('zfs send zones/'~ module_property.vm_uuid ~'@'~ module ~''~ snapshot ~' 2> /dev/null | gzip -9 > /tmp/'~ dataset_uuid ~'/'~ module_property.name ~'.zfs.gz') }}


/tmp/{{ dataset_uuid }}/manifest.json:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - makedirs : True
    - contents: |
       { 
        "v": 2,
        "uuid": "{{ dataset_uuid }}",
        "name": "{{ module_property.name }}",
        "version": "{{ module_property.version }}" ,
        "owner": "00000000-0000-0000-0000-000000000000",
        "description": "{{ module_property.description }}",
        "os": "{{ module_property.os }}",
        "type": "{{ module_property.type }}",
        "urn": "{{ module_property.os }}:briphant:{{ module_property.name }}:{{ module_property.version }}",
        "creator_name": "briphant",
        "creator_uuid": "3b1ffc44-9e62-11e4-8e98-b760856b37ca",
        "vendor_uuid": "3b1ffc44-9e62-11e4-8e98-b760856b37ca",
        "created_at": {{ salt['cmd.run']("date +%FT%TZ") }},
        "published_at": {{ salt['cmd.run']("date +%FT%TZ") }},
        "state": "active",
        "public": true,
        "disabled": false,
        "zpool": "zones",
        {{ salt['cmd.run']('mkdir -p /opt/'~ dataset_uuid ~'/  ;cp  /opt/tmp/fa4cc42a-a6a4-4f2e-9ab9-5aedbbebfc5f/wujunrong_salt-dataset_test.zfs.gz  /opt/'~ dataset_uuid ~'/'~ module_property.name ~'.zfs.gz') }} 
        
        "files": [
            {
                "path": "{{ module_property.name }}.zfs.gz",
                "sha1": "{{ salt['cmd.run']('digest -a sha1 /tmp/'~ dataset_uuid ~'/'~ module_property.name ~'.zfs.gz') }}" ,
                "size": "{{ salt['cmd.run']('ls -la  /tmp/'~ dataset_uuid ~'/'~ module_property.name ~'.zfs.gz | awk "{ print \$5}" ') }}" ,
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
       
upload_repository_{{ dataset_uuid }}:
  cmd.run:
    - name: |
        scp  -r /tmp/{{ dataset_uuid }}  root@10.75.1.202:/data/files
        ssh 10.75.1.202  svcadm restart svc:/application/dsapid:default
        ssh 10.75.1.202  chown  -R dsapid:dsapid /data/files/{{ dataset_uuid }}
    - timeout: 120    
    - require:
       - file: /tmp/{{ dataset_uuid }}/manifest.json 
   
{% endfor %}    

