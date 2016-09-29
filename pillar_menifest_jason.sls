

dataset_repository:
    dataset_test_mustang:
       image_uuid: 13f711f4-499f-11e6-8ea6-2b9fb858a619
       name: mustang-dataset_add_ssh
       version: 2.0
       description: mustang
       os: smartos
       type: zone-dataset
       ip: 10.75.1.60
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          mustang.sh: 'http://192.168.1.232/file-share/mustang.sh'
          taurus.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/Taurus/install.sh'
          mustang-Main.tar.gz: 'http://192.168.1.232/file-share/mustang-Main.tar.gz'
          install_aries.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/Aries/install.sh'
          install_lobster.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/Lobster/install.sh'
          install_giraffe.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/Giraffe/install.sh'
          install_nsq.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/NSQ/install.sh'
          install_rabbitmq.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/RabbitMQ/install.sh'
          
       dataset_install_script: |                 
          sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf
          /root/mustang.sh /root/mustang-Main.tar.gz
          #/root/taurus.sh
          #http://192.168.10.56:5000/devops/megatron/raw/master/Mustang_Real/install.sh 
          #/root/install_aries.sh
          #/root/install_lobster.sh
          #/root/install_giraffe.sh
          #/root/install_nsq.sh
          #/root/install_rabbitmq.sh
          /opt/local/bin/echo '10.75.1.70 salt'>>/etc/hosts;/opt/local/bin/sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;/opt/local/bin/echo 'http://192.168.1.232/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;/opt/local/bin/sleep 10;/usr/sbin/svcadm enable svc:/pkgsrc/salt:minion;/opt/local/bin/sleep 20          
    dataset_test_NFS:
       image_uuid: 163cd9fe-0c90-11e6-bd05-afd50e5961b6
       name: FileServer_NFS
       version: 2.0
       description: xiaotie
       os: smartos
       type: zone-dataset
       ip: 10.75.1.61
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default;"
       programm_files:
          install_file_server_nfs.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/FileServer-NFS/install.sh'
       dataset_install_script: |       
          export HOME=/root
          #export PATH=/usr/local/sbin:/usr/local/bin:/opt/local/sbin:/opt/local/bin:/usr/sbin:/usr/bin:/sbin
          #export PATH=/usr/local/sbin:/usr/local/bin:/opt/local/sbin:/opt/local/bin:/usr/sbin:/usr/bin:/sbin
          #sh /root/install_file_server_nfs.sh
          echo abc
          /opt/local/bin/echo '10.75.1.70 salt'>>/etc/hosts;/opt/local/bin/sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;/opt/local/bin/echo 'http://192.168.1.232/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;/opt/local/bin/sleep 10;/usr/sbin/svcadm enable svc:/pkgsrc/salt:minion;/opt/local/bin/sleep 20
