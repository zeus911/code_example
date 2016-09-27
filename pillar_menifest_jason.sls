

dataset_repository:
    dataset_test_mustang:
       image_uuid: 13f711f4-499f-11e6-8ea6-2b9fb858a619
       name: mustang-dataset_add_ssh
       version: 2.0
       description: mustang
       os: smartos
       type: zone-dataset
       ip: 10.75.1.60
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default;/opt/local/bin/echo '10.75.1.70 salt'>>/etc/hosts;/opt/local/bin/sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;/opt/local/bin/echo 'http://192.168.1.232/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;/opt/local/bin/sleep 60;/usr/sbin/svcadm enable svc:/pkgsrc/salt:minion"
       programm_files:
          FileServer: 'http://192.168.10.56:5000/devops/megatron/blob/master/FileServer-NFS/install.sh'

    dataset_test_FileServer_NFS:
       image_uuid: 1bd84670-055a-11e5-aaa2-0346bb21d5a1
       name: FileServer_NFS
       version: 2.0
       description: xiaotie
       os: smartos
       type: zone-dataset
       ip: 10.75.1.61
       customer_metadata: "/usr/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default;/usr/bin/echo '10.75.1.70 salt'>>/etc/hosts;/usr/bin/sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;/usr/bin/echo 'http://192.168.1.232/smartos/pkgin2014Q4/' >> /opt/local/etc/pkgin/repositories.conf;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;/opt/local/bin/salt-minion -d"
       programm_files:
          FileServer: 'http://192.168.10.56:5000/devops/megatron/blob/master/FileServer-NFS/install.sh'
        
    dataset_test_megatron:
       image_uuid: b7a38170-0c8c-11e6-8d0a-532371aa73bb
       name: megatron
       version: 2.0
       description: shengxinya
       os: smartos
       type: zone-dataset
       ip: 10.75.1.62
       customer_metadata: "/usr/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default;/usr/bin/echo '10.75.1.70 salt'>>/etc/hosts;/usr/bin/sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;/usr/bin/echo 'http://192.168.1.232/smartos/pkgin2014Q4/' >> /opt/local/etc/pkgin/repositories.conf;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;/opt/local/bin/salt-minion -d"
       programm_files:
          FileServer: 'http://192.168.10.56:5000/devops/megatron/blob/master/FileServer-NFS/install.sh'       