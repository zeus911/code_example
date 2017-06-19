

dataset_repository:

    dsapid_server:
       salt_target: no-minion
       image_uuid: a0e719d6-4e21-11e4-92eb-2bf6399552e7
       name: dsapid_server
       version: 2.0
       description: dsapid_server
       os: smartos
       type: zone-dataset
       max_physical_memory: 1024
       ip: 10.20.2.75
       gateway: 10.20.2.1
       customer_metadata: "/usr/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/bin/sed -i.bak2 's/PasswordAuthentication no/PasswordAuthentication yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          mustang_local.sh: 'http://10.0.1.38/file-share/mustang.sh'
         
       dataset_install_script: |
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")       
          sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf
          
          echo "root:root" |changepass
          echo '10.20.2.200 salt'>>/etc/hosts;sed -i.bak2 '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://salt/smartos/pkgin2014Q2/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;salt-minion -d ;sleep 20  

              

    mustang:
       salt_target: no-minion
       image_uuid: 17e009d8-91ed-11e6-825d-800c293c9b45
       name: mustang-dataset
       version: 2.0
       description: mustang
       os: smartos
       type: zone-dataset
       max_physical_memory: 5120
       ip: 192.168.2.78
       gateway: 192.168.1.1
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          mustang_local.sh: 'http://192.168.1.128/file-share/mustang.sh'
          mustang.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/Mustang_Real/install.sh'
          mustang-Main.tar.gz: 'http://192.168.31.23/quant/master/mustang/mustang_master_962.tar.gz'
          install_taurus.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/Taurus/install.sh'
          install_aries.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/Aries/install.sh'
          install_lobster.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/Lobster/install.sh'
          install_giraffe.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/Giraffe/install.sh'
          install_nsq.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/NSQ/install.sh'
          install_rabbitmq.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/RabbitMQ/install.sh'
          install_monkey.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/Monkey/install.sh'
          install_python.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/Python_Modules/install.sh'
          install_python_wu.sh: 'http://192.168.1.128/file-share/install_python.sh'          
       dataset_install_script: |
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")       
          sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf
          /root/mustang.sh mustang_master_962.tar.gz
          #/root/install_taurus.sh
          
          #sh /root/install_aries.sh
          #sh /root/install_lobster.sh
          #sh /root/install_giraffe.sh
          #sh /root/install_nsq.sh
          #sh /root/install_rabbitmq.sh
          #sh /root/install_monkey.sh

          #sh /root/install_python.sh
          #sh install_python_wu.sh
          #echo '10.75.1.70 salt'>>/etc/hosts;sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          #echo abc          

          
    EMS:
       salt_target: no-minion
       image_uuid: 07b33b7a-27a3-11e6-816f-df7d94eea009
       name: EMS
       version: 2.0
       description: lx_zone_version2_create_method_is_the_same_as_native_zone
       os: linux
       type: lx-dataset
       max_physical_memory: 5120
       ip: 10.75.1.74
       gateway: 10.75.1.1
       customer_metadata: "sed -i.bak  's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; service sshd restart;  "
       programm_files:
          install_EMS.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/EMS/install.sh'
          install_python_wu.sh: 'http://192.168.1.128/file-share/install_python.sh'          
       dataset_install_script: |
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")       
          /root/install_EMS.sh
          yum -y install lrzsz
          yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el7.noarch.rpm;echo 10.75.1.70 salt>>/etc/hosts;yum -y install salt-minion;service salt-minion start
          
          
    aerospike-server:
       salt_target: no-minion
       image_uuid: 07b33b7a-27a3-11e6-816f-df7d94eea009
       name: aerospike-server
       version: 2.0
       description: laerospike-server
       os: linux
       type: lx-dataset
       max_physical_memory: 5120
       ip: 10.75.1.74
       gateway: 10.75.1.1
       customer_metadata: "sed -i.bak  's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; service sshd restart;  "
       programm_files:
          aerospike-server.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/Aerospike_MD/aerospike-server.sh'
                  
       dataset_install_script: |
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")       
          /root/aerospike-server.sh
          yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el7.noarch.rpm;echo 10.75.1.70 salt>>/etc/hosts;yum -y install salt-minion;service salt-minion start          
          
    aerospike_Trading-server:
       salt_target: no-minion
       image_uuid: 07b33b7a-27a3-11e6-816f-df7d94eea009
       name: aerospike_Trading-server
       version: 2.0
       description: aerospike_Trading-server
       os: linux
       type: lx-dataset
       max_physical_memory: 5120
       ip: 10.75.1.74
       gateway: 10.75.1.1
       customer_metadata: "sed -i.bak  's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; service sshd restart;  "
       programm_files:
          aerospike-server.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/Aerospike_Trading/aerospike-server.sh'
                  
       dataset_install_script: |
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")       
          /root/aerospike-server.sh
          yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el7.noarch.rpm;echo 10.75.1.70 salt>>/etc/hosts;yum -y install salt-minion;service salt-minion start

    midway:
       salt_target: no-minion
       image_uuid: 07b33b7a-27a3-11e6-816f-df7d94eea009
       name: midway
       version: 2.0
       description: midway
       os: linux
       type: lx-dataset
       max_physical_memory: 5120
       ip: 10.75.1.74
       gateway: 10.75.1.1
       customer_metadata: "sed -i.bak  's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; service sshd restart;  "
       programm_files:
          install_midway.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/Midway/install.sh'
                  
       dataset_install_script: |
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")       
          /root/install_midway.sh
          yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el7.noarch.rpm;echo 10.75.1.70 salt>>/etc/hosts;yum -y install salt-minion;service salt-minion start

    MDF:
       salt_target: no-minion
       image_uuid: 07b33b7a-27a3-11e6-816f-df7d94eea009
       name: MDF
       version: 2.0
       description: MDF
       os: linux
       type: lx-dataset
       max_physical_memory: 5120
       ip: 10.75.1.76
       gateway: 10.75.1.1
       customer_metadata: "sed -i.bak  's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; service sshd restart;  "
       programm_files:
          install_MDF.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/MDF/install.sh'
                  
       dataset_install_script: |
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")       
          /root/install_MDF.sh
          yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el7.noarch.rpm;echo 10.75.1.70 salt>>/etc/hosts;yum -y install salt-minion;service salt-minion start
          
    vpnservice:
       salt_target: no-minion
       image_uuid: 74be319f-2753-4b0a-8ee2-514249dc3935
       name: native_zone_no-minion_vpn
       version: 2.0
       description: native_zone_no-minion_vpn
       os: smartos
       type: zone-dataset
       max_physical_memory: 5120
       ip: 10.75.1.74
       gateway: 10.75.1.1
       customer_metadata: "sed -i.bak  's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; service sshd restart;  "
       programm_files:
          test.sh: 'http://192.168.1.128/file-share/install_python.sh'          
       dataset_install_script: |
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")       
          
          yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el7.noarch.rpm;echo 10.75.1.70 salt>>/etc/hosts;yum -y install salt-minion;service salt-minion start                 
          

    dataset_test_NFS:
       salt_target: no-minion
       image_uuid: 163cd9fe-0c90-11e6-bd05-afd50e5961b6
       name: FileServer_NFS
       version: 2.0
       description: xiaotie
       os: smartos
       type: zone-dataset
       max_physical_memory: 5120
       ip: 192.168.2.79
       gateway: 10.75.1.1
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default;"
       programm_files:
          install_file_server_nfs.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/FileServer-NFS/install.sh'
       dataset_install_script: |
          set -e       
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name") 
          export HOME=/root
          export PATH=/usr/local/sbin:/usr/local/bin:/opt/local/sbin:/opt/local/bin:/usr/sbin:/usr/bin:/sbin
          #export PATH=/usr/local/sbin:/usr/local/bin:/opt/local/sbin:/opt/local/bin:/usr/sbin:/usr/bin:/sbin
          #/root/install_file_server_nfs.sh
          echo abc
          /opt/local/bin/echo '10.75.1.70 salt'>>/etc/hosts;/opt/local/bin/sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;/opt/local/bin/echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;/opt/local/bin/sleep 10;/usr/sbin/svcadm enable svc:/pkgsrc/salt:minion;/opt/local/bin/sleep 20

    dataset_test_kvm:
       salt_target: jinhao
       salt_target_for_KVM_zone: NFS
       image_uuid: 66d919a8-132a-11e7-a7b8-5b99fa122880
       name: NFS-Server-On-centos7
       version: 2.0
       description: NFS-Server-On-centos7_modify_/etc/exports_then_systemctl_restart_nfs-server
       os: smartos
       type: zvol
       max_physical_memory: 1024
       ip: 10.0.1.73
       gateway: 10.0.1.1
       customer_metadata: "hostname NFS;echo NFS > /etc/hostname;hostname;echo '10.0.1.38 salt'>>/etc/hosts;sed -i.bak  's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; service sshd restart;wget -O /etc/yum.repos.d/centos7_software.repo http://10.0.1.38/yum-repo-centos7/centos7_software.repo;sudo yum -y clean expire-cache;sudo yum --disablerepo='*' --enablerepo='wujunrongrepo' -y install salt-minion; sudo systemctl start salt-minion;"
       programm_files:
          install_EMS.sh: 'http://10.0.1.38/yum-repo-centos7/centos7_software.repo'
       dataset_install_script: |       
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name") 
          yum -y --disablerepo='*' --enablerepo='wujunrongrepo' install nfs-utils nfs-utils-lib
          systemctl enable rpcbind
          systemctl enable nfs-server
          systemctl enable nfs-lock
          systemctl enable nfs-idmap
          
          systemctl start rpcbind
          systemctl start nfs-server
          systemctl start nfs-lock
          systemctl start nfs-idmap          
          systemctl disable firewalld
          systemctl stop firewalld
          cat>/etc/exports<<EOF
          /root            10.0.1.38(rw,sync,no_root_squash,no_all_squash)
          EOF

    kvm_nfs_test:
       salt_target: no-minion
       image_uuid:  bc2074f8-468b-11e7-8b5f-b8aeed712acc
       name: kvm_nfs_test
       version: 2.0
       description: used-for-generating-lx-dataset
       os: smartos
       type: zvol
       max_physical_memory: 1024
       ip: 10.0.1.74
       gateway: 10.0.1.1
       customer_metadata: "echo abc"
       programm_files:
          install_EMS.sh: 'http://10.0.1.38/yum-repo-centos7/centos7_software.repo'
       dataset_install_script: |       
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name") 

         
    dataset_test_lx:
       salt_target: no-minion
       image_uuid: 46bbd160-9846-11e6-b5b7-79744c798854
       name: lx-test
       version: 2.0
       description: xiaotie
       os: smartos
       type: lx-dataset
       max_physical_memory: 5120
       ip: 192.168.2.79
       gateway: 10.75.1.1
       customer_metadata: "NULL"
       programm_files:
          install_EMS.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/EMS/install.sh'
       dataset_install_script: |       
          log_file_name=`date +%F-%H_%M`_dataset_install.log
          exec &> >(tee "/root/$log_file_name") 
          #export HOME=/root
          #export PATH=/usr/local/sbin:/usr/local/bin:/opt/local/sbin:/opt/local/bin:/usr/sbin:/usr/bin:/sbin
          #export PATH=/usr/local/sbin:/usr/local/bin:/opt/local/sbin:/opt/local/bin:/usr/sbin:/usr/bin:/sbin
          #/root/install_file_server_nfs.sh
          echo abc
          #/opt/local/bin/echo '10.75.1.70 salt'>>/etc/hosts;/opt/local/bin/sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;/opt/local/bin/echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;/opt/local/bin/sleep 10;/usr/sbin/svcadm enable svc:/pkgsrc/salt:minion;/opt/local/bin/sleep 20
          
    alpha_test_leofs1:
       salt_target: no-minion
       image_uuid: 1bd84670-055a-11e5-aaa2-0346bb21d5a1
       name: alpha_test_leofs1
       version: 2.0
       description: alpha_test_leofs1
       os: smartos
       type: zone-dataset
       max_physical_memory: 5120
       ip: 192.168.1.80
       gateway: 192.168.1.1
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          leo_manager.conf.template: 'http://192.168.1.148/file-share/leo_manager.conf.leofs_1'
          leo_gateway.conf.template: 'http://192.168.1.148/file-share/leo_gateway.conf.leofs_1'
          leo_storage.conf.template: 'http://192.168.1.148/file-share/leo_storage.conf.leofs_1'
          
       dataset_install_script: |
          #set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")                 
          sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf

          curl -O https://project-fifo.net/fifo.gpg
          gpg --primary-keyring /opt/local/etc/gnupg/pkgsrc.gpg --import < /root/fifo.gpg
          gpg --keyring /opt/local/etc/gnupg/pkgsrc.gpg --fingerprint
          
          VERSION=rel
          cp /opt/local/etc/pkgin/repositories.conf /opt/local/etc/pkgin/repositories.conf.original
          sed -i.bak  '$d' /opt/local/etc/pkgin/repositories.conf
          echo "http://192.168.1.148/fifo-leofs-for-minimal-64-lts-14.4.2/" >> /opt/local/etc/pkgin/repositories.conf
          rm -fr /var/db/pkgin/*
          pkgin -fy up
          pkgin -y install coreutils sudo gawk gsed
          pkgin -y install leo_manager leo_gateway leo_storage
          
          cp  /opt/local/leo_manager/etc/leo_manager.conf  /opt/local/leo_manager/etc/leo_manager.conf.original
          cp  /opt/local/leo_gateway/etc/leo_gateway.conf  /opt/local/leo_gateway/etc/leo_gateway.conf.original
          cp  /opt/local/leo_storage/etc/leo_storage.conf  /opt/local/leo_storage/etc/leo_storage.conf.original
          
          mv -f /root/leo_manager.conf.template    /opt/local/leo_manager/etc/leo_manager.conf
          mv -f /root/leo_gateway.conf.template    /opt/local/leo_gateway/etc/leo_gateway.conf
          mv -f /root/leo_storage.conf.template    /opt/local/leo_storage/etc/leo_storage.conf
          
          
          mv -f /opt/local/etc/pkgin/repositories.conf.original  /opt/local/etc/pkgin/repositories.conf
          
          
          #svcadm enable epmd
          #svcadm enable leofs/manager
          #svcadm enable leofs/storage
          #sleep 3
          #leofs-adm status
          #leofs-adm start
          #sleep 3
          #svcadm enable leofs/gateway
          #leofs-adm status
          
          sed -i.bak2  '$d' /opt/local/etc/pkgin/repositories.conf
          echo '192.168.1.148 salt'>>/etc/hosts;sed -i.bak2 '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.148/smartos/pkgin2014Q4/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;salt-minion -d ;sleep 20
          #echo abc       

      

    alpha_test_leofs2:
       salt_target: no-minion
       image_uuid: 1bd84670-055a-11e5-aaa2-0346bb21d5a1
       name: alpha_test_leofs2
       version: 2.0
       description: alpha_test_leofs2
       os: smartos
       type: zone-dataset
       max_physical_memory: 1024
       ip: 192.168.1.81
       gateway: 192.168.1.1
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          leo_manager.conf.template: 'http://192.168.1.148/file-share/leo_manager.conf.leofs_2'
   
       dataset_install_script: |
          #set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")                 
          sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf

          curl -O https://project-fifo.net/fifo.gpg
          gpg --primary-keyring /opt/local/etc/gnupg/pkgsrc.gpg --import < /root/fifo.gpg
          gpg --keyring /opt/local/etc/gnupg/pkgsrc.gpg --fingerprint
          
          VERSION=rel
          cp /opt/local/etc/pkgin/repositories.conf /opt/local/etc/pkgin/repositories.conf.original
          sed -i.bak  '$d' /opt/local/etc/pkgin/repositories.conf
          echo "http://192.168.1.148/fifo-leofs-for-minimal-64-lts-14.4.2/" >> /opt/local/etc/pkgin/repositories.conf
          rm -fr /var/db/pkgin/*
          pkgin -fy up
          pkgin -y install coreutils sudo gawk gsed
          pkgin -y install leo_manager leo_gateway leo_storage
          
          cp  /opt/local/leo_manager/etc/leo_manager.conf  /opt/local/leo_manager/etc/leo_manager.conf.original
          mv -f /root/leo_manager.conf.template    /opt/local/leo_manager/etc/leo_manager.conf
          
          mv -f /opt/local/etc/pkgin/repositories.conf.original  /opt/local/etc/pkgin/repositories.conf
          
          #svcadm enable epmd
          #svcadm enable leofs/manager
          
          #sed -i.bak2  '$d' /opt/local/etc/pkgin/repositories.conf
          echo '192.168.1.148 salt'>>/etc/hosts;sed -i.bak2 '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.148/smartos/pkgin2014Q4/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;salt-minion -d ;sleep 20     

          #echo '10.75.1.70 salt'>>/etc/hosts;sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          #echo abc   


    fifo_test:
       salt_target: no-minion
       image_uuid: 70e3ae72-96b6-11e6-9056-9737fd4d0764
       name: fifo_shanghai
       version: 2.0
       description: fifo_shanghai
       os: smartos
       type: zone-dataset
       max_physical_memory: 3072
       ip: 192.168.1.85
       gateway: 192.168.1.1
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          leo_manager.conf.template: 'http://192.168.1.148/file-share/leo_manager.conf.leofs_2'

       dataset_install_script: |
          #!/bin/bash
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")                 

          zfs set mountpoint=/data zones/$(zonename)/data
          
          cd /data
          curl -O https://project-fifo.net/fifo.gpg
          gpg --primary-keyring /opt/local/etc/gnupg/pkgsrc.gpg --import < fifo.gpg
          gpg --keyring /opt/local/etc/gnupg/pkgsrc.gpg --fingerprint

          sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf
          echo "http://192.168.1.148/fifo-0.91/" >> /opt/local/etc/pkgin/repositories.conf
          pkgin -fy up
          pkgin -y install fifo-snarl fifo-sniffle fifo-howl fifo-cerberus

          
          svcadm enable epmd
          svcadm enable snarl
          svcadm enable sniffle
          svcadm enable howl
          sleep 60
          svcs epmd snarl sniffle howl
          
          
          snarl-admin init default MyOrg Users admin admin
          
          sniffle-admin init-leofs 192.168.1.80.xip.io
          
          #echo '10.75.1.70 salt'>>/etc/hosts;sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          #echo abc   
          
    home_leofs1:
       salt_target: no-minion
       image_uuid: 1bd84670-055a-11e5-aaa2-0346bb21d5a1
       name: home_leofs1
       version: 2.0
       description: home_leofs1
       os: smartos
       type: zone-dataset
       max_physical_memory: 5120
       ip: 10.0.1.80
       gateway: 10.0.1.1
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          leo_manager.conf.template: 'http://salt/file-share/leo_manager.conf.leofs_1'
          leo_gateway.conf.template: 'http://salt/file-share/leo_gateway.conf.leofs_1'
          leo_storage.conf.template: 'http://salt/file-share/leo_storage.conf.leofs_1'
          
       dataset_install_script: |
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")                 
          #sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf

          
          echo '10.0.1.38 salt'>>/etc/hosts;sed -i.bak2 '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://salt/smartos/pkgin2014Q4/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;salt-minion -d ;sleep 20  
          #sed -i.bak2  '$d' /opt/local/etc/pkgin/repositories.conf
          
          curl -O http://10.0.1.38/file-share/fifo.gpg
          gpg --primary-keyring /opt/local/etc/gnupg/pkgsrc.gpg --import < /root/fifo.gpg
          gpg --keyring /opt/local/etc/gnupg/pkgsrc.gpg --fingerprint
          
          VERSION=rel
          cp /opt/local/etc/pkgin/repositories.conf /opt/local/etc/pkgin/repositories.conf.original
          sed -i.bak  '$d' /opt/local/etc/pkgin/repositories.conf
          echo "http://salt/fifo-leofs-for-minimal-64-lts-14.4.2/" >> /opt/local/etc/pkgin/repositories.conf
          rm -fr /var/db/pkgin/*
          pkgin -fy up
          pkgin -y install coreutils sudo gawk gsed
          pkgin -y install leo_manager leo_gateway leo_storage
          
          cp  /opt/local/leo_manager/etc/leo_manager.conf  /opt/local/leo_manager/etc/leo_manager.conf.original
          cp  /opt/local/leo_gateway/etc/leo_gateway.conf  /opt/local/leo_gateway/etc/leo_gateway.conf.original
          cp  /opt/local/leo_storage/etc/leo_storage.conf  /opt/local/leo_storage/etc/leo_storage.conf.original
          
          mv -f /root/leo_manager.conf.template    /opt/local/leo_manager/etc/leo_manager.conf
          mv -f /root/leo_gateway.conf.template    /opt/local/leo_gateway/etc/leo_gateway.conf
          mv -f /root/leo_storage.conf.template    /opt/local/leo_storage/etc/leo_storage.conf
          
          
          mv -f /opt/local/etc/pkgin/repositories.conf.original  /opt/local/etc/pkgin/repositories.conf
          
          
          svcadm enable epmd
          svcadm enable leofs/manager
          svcadm enable leofs/storage
          sleep 3
          leofs-adm status
          leofs-adm start
          sleep 3
          svcadm enable leofs/gateway
          leofs-adm status
          
 
          #echo abc       

      

    home_leofs2:
       salt_target: no-minion
       image_uuid: 1bd84670-055a-11e5-aaa2-0346bb21d5a1
       name: home_leofs2
       version: 2.0
       description: home_leofs2
       os: smartos
       type: zone-dataset
       max_physical_memory: 1024
       ip: 10.0.1.81
       gateway: 10.0.1.1
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          leo_manager.conf.template: 'http://salt/file-share/leo_manager.conf.leofs_2'
   
       dataset_install_script: |
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")                 
          #sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf

          echo '10.0.1.38 salt'>>/etc/hosts;sed -i.bak2 '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://salt/smartos/pkgin2014Q4/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;salt-minion -d ;sleep 20  
          #sed -i.bak2  '$d' /opt/local/etc/pkgin/repositories.conf
          
          curl -O http://10.0.1.38/file-share/fifo.gpg
          gpg --primary-keyring /opt/local/etc/gnupg/pkgsrc.gpg --import < /root/fifo.gpg
          gpg --keyring /opt/local/etc/gnupg/pkgsrc.gpg --fingerprint
          
          VERSION=rel
          cp /opt/local/etc/pkgin/repositories.conf /opt/local/etc/pkgin/repositories.conf.original
          sed -i.bak  '$d' /opt/local/etc/pkgin/repositories.conf
          echo "http://salt/fifo-leofs-for-minimal-64-lts-14.4.2/" >> /opt/local/etc/pkgin/repositories.conf
          rm -fr /var/db/pkgin/*
          pkgin -fy up
          pkgin -y install coreutils sudo gawk gsed
          pkgin -y install leo_manager leo_gateway leo_storage
          
          cp  /opt/local/leo_manager/etc/leo_manager.conf  /opt/local/leo_manager/etc/leo_manager.conf.original
          mv -f /root/leo_manager.conf.template    /opt/local/leo_manager/etc/leo_manager.conf
          
          mv -f /opt/local/etc/pkgin/repositories.conf.original  /opt/local/etc/pkgin/repositories.conf
          
          #svcadm enable epmd
          #svcadm enable leofs/manager
          
          #sed -i.bak2  '$d' /opt/local/etc/pkgin/repositories.conf

          #echo '10.75.1.70 salt'>>/etc/hosts;sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          #echo abc   


 
    home_hp_leofs1:
       salt_target: no-minion
       image_uuid: 1bd84670-055a-11e5-aaa2-0346bb21d5a1
       name: home_hp_leofs1
       version: 2.0
       description: home_hp_leofs1
       os: smartos
       type: zone-dataset
       max_physical_memory: 5120
       ip: 10.0.1.130
       gateway: 10.0.1.1
       customer_metadata: "/usr/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          leo_manager.conf.template: 'http://salt/file-share/leo_manager.conf.leofs_1'
          leo_gateway.conf.template: 'http://salt/file-share/leo_gateway.conf.leofs_1'
          leo_storage.conf.template: 'http://salt/file-share/leo_storage.conf.leofs_1'
          
       dataset_install_script: |
          #set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")                 
          #sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf

          
          echo '10.0.1.38 salt'>>/etc/hosts;sed -i.bak2 '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://salt/smartos/pkgin2014Q4/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;salt-minion -d ;sleep 20  
          #sed -i.bak2  '$d' /opt/local/etc/pkgin/repositories.conf
          
          route delete default 10.0.1.1 
          route  add default 10.0.1.101
          curl -O https://project-fifo.net/fifo.gpg
          gpg --primary-keyring /opt/local/etc/gnupg/pkgsrc.gpg --import < /root/fifo.gpg
          gpg --keyring /opt/local/etc/gnupg/pkgsrc.gpg --fingerprint
          
          VERSION=rel
          cp /opt/local/etc/pkgin/repositories.conf /opt/local/etc/pkgin/repositories.conf.original
          sed -i.bak  '$d' /opt/local/etc/pkgin/repositories.conf
          echo "http://salt/fifo-leofs-for-minimal-64-lts-14.4.2/" >> /opt/local/etc/pkgin/repositories.conf
          rm -fr /var/db/pkgin/*
          pkgin -fy up
          pkgin -y install coreutils sudo gawk gsed
          pkgin -y install leo_manager leo_gateway leo_storage
          
          cp  /opt/local/leo_manager/etc/leo_manager.conf  /opt/local/leo_manager/etc/leo_manager.conf.original
          cp  /opt/local/leo_gateway/etc/leo_gateway.conf  /opt/local/leo_gateway/etc/leo_gateway.conf.original
          cp  /opt/local/leo_storage/etc/leo_storage.conf  /opt/local/leo_storage/etc/leo_storage.conf.original
          
          mv -f /root/leo_manager.conf.template    /opt/local/leo_manager/etc/leo_manager.conf
          mv -f /root/leo_gateway.conf.template    /opt/local/leo_gateway/etc/leo_gateway.conf
          mv -f /root/leo_storage.conf.template    /opt/local/leo_storage/etc/leo_storage.conf
          
          
          mv -f /opt/local/etc/pkgin/repositories.conf.original  /opt/local/etc/pkgin/repositories.conf
          
          
          #svcadm enable epmd
          #svcadm enable leofs/manager
          #svcadm enable leofs/storage
          #sleep 3
          #leofs-adm status
          #leofs-adm start
          #sleep 3
          #svcadm enable leofs/gateway
          #leofs-adm status
          
 
          #echo abc       

      

    home_hp_leofs2:
       salt_target: no-minion
       image_uuid: 1bd84670-055a-11e5-aaa2-0346bb21d5a1
       name: home_hp_leofs2
       version: 2.0
       description: home_hp_leofs2
       os: smartos
       type: zone-dataset
       max_physical_memory: 1024
       ip: 10.0.1.131
       gateway: 10.0.1.1
       customer_metadata: "/usr/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          leo_manager.conf.template: 'http://salt/file-share/leo_manager.conf.leofs_2'
   
       dataset_install_script: |
          #set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")                 
          #sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf

          echo '10.0.1.38 salt'>>/etc/hosts;sed -i.bak2 '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://salt/smartos/pkgin2014Q4/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;salt-minion -d ;sleep 20  
          #sed -i.bak2  '$d' /opt/local/etc/pkgin/repositories.conf
          
          route delete default 10.0.1.1 
          route  add default 10.0.1.101
          curl -O https://project-fifo.net/fifo.gpg

          gpg --primary-keyring /opt/local/etc/gnupg/pkgsrc.gpg --import < /root/fifo.gpg
          gpg --keyring /opt/local/etc/gnupg/pkgsrc.gpg --fingerprint
          
          VERSION=rel
          cp /opt/local/etc/pkgin/repositories.conf /opt/local/etc/pkgin/repositories.conf.original
          sed -i.bak  '$d' /opt/local/etc/pkgin/repositories.conf
          echo "http://salt/fifo-leofs-for-minimal-64-lts-14.4.2/" >> /opt/local/etc/pkgin/repositories.conf
          rm -fr /var/db/pkgin/*
          pkgin -fy up
          pkgin -y install coreutils sudo gawk gsed
          pkgin -y install leo_manager leo_gateway leo_storage
          
          cp  /opt/local/leo_manager/etc/leo_manager.conf  /opt/local/leo_manager/etc/leo_manager.conf.original
          mv -f /root/leo_manager.conf.template    /opt/local/leo_manager/etc/leo_manager.conf
          
          mv -f /opt/local/etc/pkgin/repositories.conf.original  /opt/local/etc/pkgin/repositories.conf
          
          #svcadm enable epmd
          #svcadm enable leofs/manager
          
          #sed -i.bak2  '$d' /opt/local/etc/pkgin/repositories.conf

          #echo '10.75.1.70 salt'>>/etc/hosts;sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          #echo abc   


    home_beijing_office_leofs1:
       salt_target: beijing_office
       image_uuid: 1bd84670-055a-11e5-aaa2-0346bb21d5a1
       name: home_beijing_office_leofs1
       version: 2.0
       description: home_beijing_office_leofs1
       os: smartos
       type: zone-dataset
       max_physical_memory: 5120
       ip: 10.20.2.130
       gateway: 10.20.2.1
       customer_metadata: "/usr/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          leo_manager.conf.template: 'http://salt/file-share/leo_manager.conf.leofs_1'
          leo_gateway.conf.template: 'http://salt/file-share/leo_gateway.conf.leofs_1'
          leo_storage.conf.template: 'http://salt/file-share/leo_storage.conf.leofs_1'
          
       dataset_install_script: |
          #set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")                 
          #sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf

          
          echo '10.20.2.200 salt'>>/etc/hosts;sed -i.bak2 '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://salt/smartos/pkgin2014Q4/' >> /opt/local/etc/pkgin/repositories.conf;echo "http://salt/fifo-leofs-for-minimal-64-lts-14.4.2/" >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;salt-minion -d ;sleep 20  
          #sed -i.bak2  '$d' /opt/local/etc/pkgin/repositories.conf
          
          #route delete default 10.0.1.1 
          #route  add default 10.0.1.101
          curl -O https://project-fifo.net/fifo.gpg
          gpg --primary-keyring /opt/local/etc/gnupg/pkgsrc.gpg --import < /root/fifo.gpg
          gpg --keyring /opt/local/etc/gnupg/pkgsrc.gpg --fingerprint
          
          VERSION=rel
          #cp /opt/local/etc/pkgin/repositories.conf /opt/local/etc/pkgin/repositories.conf.original
          #sed -i.bak  '$d' /opt/local/etc/pkgin/repositories.conf
          #echo "http://salt/fifo-leofs-for-minimal-64-lts-14.4.2/" >> /opt/local/etc/pkgin/repositories.conf
          #rm -fr /var/db/pkgin/*
          #pkgin -fy up
          pkgin -y install coreutils sudo gawk gsed
          pkgin -y install leo_manager leo_gateway leo_storage
          
          cp  /opt/local/leo_manager/etc/leo_manager.conf  /opt/local/leo_manager/etc/leo_manager.conf.original
          cp  /opt/local/leo_gateway/etc/leo_gateway.conf  /opt/local/leo_gateway/etc/leo_gateway.conf.original
          cp  /opt/local/leo_storage/etc/leo_storage.conf  /opt/local/leo_storage/etc/leo_storage.conf.original
          
          mv -f /root/leo_manager.conf.template    /opt/local/leo_manager/etc/leo_manager.conf
          mv -f /root/leo_gateway.conf.template    /opt/local/leo_gateway/etc/leo_gateway.conf
          mv -f /root/leo_storage.conf.template    /opt/local/leo_storage/etc/leo_storage.conf
          
          
          #mv -f /opt/local/etc/pkgin/repositories.conf.original  /opt/local/etc/pkgin/repositories.conf
          
          
          #svcadm enable epmd
          #svcadm enable leofs/manager
          #svcadm enable leofs/storage
          #sleep 3
          #leofs-adm status
          #leofs-adm start
          #sleep 3
          #svcadm enable leofs/gateway
          #leofs-adm status
          
 
          #echo abc       

      

    home_beijing_office_leofs2:
       salt_target: beijing_office
       image_uuid: 1bd84670-055a-11e5-aaa2-0346bb21d5a1
       name: home_beijing_office_leofs2
       version: 2.0
       description: home_beijing_office_leofs2
       os: smartos
       type: zone-dataset
       max_physical_memory: 1024
       ip: 10.20.2.131
       gateway: 10.20.2.1
       customer_metadata: "/usr/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          leo_manager.conf.template: 'http://salt/file-share/leo_manager.conf.leofs_2'
   
       dataset_install_script: |
          #set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")                 
          #sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf

          echo '10.20.2.200 salt'>>/etc/hosts;sed -i.bak2 '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://salt/smartos/pkgin2014Q4/' >> /opt/local/etc/pkgin/repositories.conf;echo "http://salt/fifo-leofs-for-minimal-64-lts-14.4.2/" >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;salt-minion -d ;sleep 20  
          #sed -i.bak2  '$d' /opt/local/etc/pkgin/repositories.conf
          
          #route delete default 10.0.1.1 
          #route  add default 10.0.1.101
          curl -O https://project-fifo.net/fifo.gpg

          gpg --primary-keyring /opt/local/etc/gnupg/pkgsrc.gpg --import < /root/fifo.gpg
          gpg --keyring /opt/local/etc/gnupg/pkgsrc.gpg --fingerprint
          
          VERSION=rel
          #cp /opt/local/etc/pkgin/repositories.conf /opt/local/etc/pkgin/repositories.conf.original
          #sed -i.bak  '$d' /opt/local/etc/pkgin/repositories.conf
          #echo "http://salt/fifo-leofs-for-minimal-64-lts-14.4.2/" >> /opt/local/etc/pkgin/repositories.conf
          #rm -fr /var/db/pkgin/*
          #pkgin -fy up
          pkgin -y install coreutils sudo gawk gsed
          pkgin -y install leo_manager leo_gateway leo_storage
          
          cp  /opt/local/leo_manager/etc/leo_manager.conf  /opt/local/leo_manager/etc/leo_manager.conf.original
          mv -f /root/leo_manager.conf.template    /opt/local/leo_manager/etc/leo_manager.conf
          
          #mv -f /opt/local/etc/pkgin/repositories.conf.original  /opt/local/etc/pkgin/repositories.conf
          
          #svcadm enable epmd
          #svcadm enable leofs/manager
          
          #sed -i.bak2  '$d' /opt/local/etc/pkgin/repositories.conf

          #echo '10.75.1.70 salt'>>/etc/hosts;sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          #echo abc   




    home_fifo_9_1:
       salt_target: no-minion
       image_uuid: 70e3ae72-96b6-11e6-9056-9737fd4d0764
       name: home_fifo_9_1
       version: 2.0
       description: home_fifo_9_1
       os: smartos
       type: zone-dataset
       max_physical_memory: 3072
       ip: 10.0.1.85
       gateway: 10.0.1.1
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          leo_manager.conf.template: 'http://salt/file-share/leo_manager.conf.leofs_2'

       dataset_install_script: |
          #!/bin/bash
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")                 
          

          echo '10.0.1.38 salt'>>/etc/hosts;sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://salt/salt-2016Q3/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          zfs set mountpoint=/data zones/$(zonename)/data
          
          cd /data
          curl -O https://project-fifo.net/fifo.gpg
          gpg --primary-keyring /opt/local/etc/gnupg/pkgsrc.gpg --import < fifo.gpg
          gpg --keyring /opt/local/etc/gnupg/pkgsrc.gpg --fingerprint

          sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf
          echo "http://salt/fifo-0.91/" >> /opt/local/etc/pkgin/repositories.conf
          pkgin -fy up
          pkgin -y install fifo-snarl fifo-sniffle fifo-howl fifo-cerberus

          
          svcadm enable epmd
          svcadm enable snarl
          svcadm enable sniffle
          svcadm enable howl
          sleep 60
          svcs epmd snarl sniffle howl
          
          
          snarl-admin init default MyOrg Users admin admin
          
          sniffle-admin init-leofs 10.0.1.80.xip.io
          
   
          #echo abc   
          
    home_fifo2_9_1:
       salt_target: no-minion
       image_uuid: 70e3ae72-96b6-11e6-9056-9737fd4d0764
       name: home_fifo2_9_1
       version: 2.0
       description: home_fifo2_9_1
       os: smartos
       type: zone-dataset
       max_physical_memory: 3072
       ip: 10.0.1.86
       gateway: 10.0.1.1
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          leo_manager.conf.template: 'http://salt/file-share/leo_manager.conf.leofs_2'

       dataset_install_script: |
          #!/bin/bash
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")                 
          
          echo '10.0.1.38 salt'>>/etc/hosts;sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://salt/salt-2016Q3/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          zfs set mountpoint=/data zones/$(zonename)/data
          
          cd /data
          curl -O https://project-fifo.net/fifo.gpg
          gpg --primary-keyring /opt/local/etc/gnupg/pkgsrc.gpg --import < fifo.gpg
          gpg --keyring /opt/local/etc/gnupg/pkgsrc.gpg --fingerprint

          sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf
          echo "http://salt/fifo-0.91/" >> /opt/local/etc/pkgin/repositories.conf
          pkgin -fy up
          pkgin -y install fifo-snarl fifo-sniffle fifo-howl fifo-cerberus

          
          svcadm enable epmd
          svcadm enable snarl
          svcadm enable sniffle
          svcadm enable howl
          sleep 60
          svcs epmd snarl sniffle howl
          
          /opt/local/fifo-sniffle/bin/sniffle-admin cluster join 'sniffle@10.0.1.85'
          /opt/local/fifo-sniffle/bin/sniffle-admin cluster plan
          /opt/local/fifo-sniffle/bin/sniffle-admin cluster commit
          
          /opt/local/fifo-howl/bin/howl-admin cluster join 'howl@10.0.1.85'
          /opt/local/fifo-howl/bin/howl-admin cluster plan
          /opt/local/fifo-howl/bin/howl-admin cluster commit
          
          /opt/local/fifo-snarl/bin/snarl-admin cluster join 'snarl@10.0.1.85'
          /opt/local/fifo-snarl/bin/snarl-admin cluster plan
          /opt/local/fifo-snarl/bin/snarl-admin   cluster commit

          
          /opt/local/fifo-snarl/bin/snarl-admin member-status
          /opt/local/fifo-sniffle/bin/sniffle-admin member-status
          /opt/local/fifo-howl/bin/howl-admin member-status
          
          #snarl-admin init default MyOrg Users admin admin
          #sniffle-admin init-leofs 10.0.1.80.xip.io
          #svcadm restart sniffle
   
          #echo abc   
     

    fifo_1_aio_9_1_home:
       salt_target: no-minion
       image_uuid: f097790d-183d-44fa-b795-44ab5f82c64f
       name: fifo_1_aio_9_1_home
       version: 2.0
       description: fifo_1_aio_9_1_home
       os: smartos
       type: zone-dataset
       max_physical_memory: 3072
       ip: 10.0.1.21
       gateway: 10.0.1.1
       customer_metadata: "/usr/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          snarl.conf.template: 'http://salt/fifo-0.91/snarl.conf.0.9.1'
          sniffle.conf.template: 'http://salt/fifo-0.91/sniffle.conf.0.9.1'
          howl.conf.template: 'http://salt/fifo-0.91/howl.conf.0.9.1'

       dataset_install_script: |
          #!/bin/bash
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")                 
          
          echo '10.0.1.38 salt'>>/etc/hosts;sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;sed -i.bak2 '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://salt/smartos/pkgin2015Q4/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20

          #fifo-config
          #svcadm enable epmd
          #svcadm enable snarl
          #svcadm enable howl
          #svcadm enable sniffle

    fifo_2_aio_9_1_home:
       salt_target: no-minion
       image_uuid: f097790d-183d-44fa-b795-44ab5f82c64f
       name: fifo_2_aio_9_1_home
       version: 2.0
       description: fifo_2_aio_9_1_home
       os: smartos
       type: zone-dataset
       max_physical_memory: 3072
       ip: 10.0.1.22
       gateway: 10.0.1.1
       customer_metadata: "/usr/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          snarl.conf.template: 'http://salt/fifo-0.91/snarl.conf.0.9.1'
          sniffle.conf.template: 'http://salt/fifo-0.91/sniffle.conf.0.9.1'
          howl.conf.template: 'http://salt/fifo-0.91/howl.conf.0.9.1'

       dataset_install_script: |
          #!/bin/bash
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")                 
          
          echo '10.0.1.38 salt'>>/etc/hosts;sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;sed -i.bak2 '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://salt/smartos/pkgin2015Q4/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20

          #fifo-config
          #svcadm enable epmd
          #svcadm enable snarl
          #svcadm enable howl
          #svcadm enable sniffle

    old_fifo_0_7_home_1:
       salt_target: no-minion
       image_uuid: 1bd84670-055a-11e5-aaa2-0346bb21d5a1
       name: old_fifo_0_7_home_1
       version: 2.0
       description: old_fifo_0_7_home_1
       os: smartos
       type: zone-dataset
       max_physical_memory: 3072
       ip: 10.0.1.195
       gateway: 10.0.1.1
       customer_metadata: "/usr/bin/sed  -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          unixodbc-2.3.0nb2.tgz: 'http://10.0.1.38/fifo-old/unixodbc-2.3.0nb2.tgz'
          perl-5.20.1.tgz: 'http://10.0.1.38/fifo-old/perl-5.20.1.tgz'
          chunter-0.7.0p4.gz: 'http://10.0.1.38/fifo-0.7.0/chunter-0.7.0p4.gz'          
          fifo-snarl-0.7.0.tgz: 'http://10.0.1.38/fifo-0.7.0/fifo-snarl-0.7.0.tgz'
          fifo-snarl-0.7.0p6.tgz: 'http://10.0.1.38/fifo-0.7.0/fifo-snarl-0.7.0p6.tgz'
          fifo-howl-0.7.0.tgz: 'http://10.0.1.38/fifo-0.7.0/fifo-howl-0.7.0.tgz'
          fifo-howl-0.7.0p1.tgz: 'http://10.0.1.38/fifo-0.7.0/fifo-howl-0.7.0p1.tgz'
          fifo-sniffle-0.7.0.tgz: 'http://10.0.1.38/fifo-0.7.0/fifo-sniffle-0.7.0.tgz'
          fifo-sniffle-0.7.0p7.tgz: 'http://10.0.1.38/fifo-0.7.0/fifo-sniffle-0.7.0p7.tgz'
          fifo-cerberus-0.7.0p9.tgz: 'http://10.0.1.38/fifo-0.7.0/fifo-cerberus-0.7.0p9.tgz'
          erlang-18.0nb1.tgz: 'http://10.0.1.38/fifo-old/erlang-18.0nb1.tgz'


       dataset_install_script: |
          #set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")       
 
          route delete default 10.0.1.1 
          route  add default 10.0.1.101
          netstat -r


          #install salt
          echo '10.0.1.38 salt'>>/etc/hosts;sed -i.bak2 '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://salt/smartos/pkgin2014Q4/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;salt-minion -d ;sleep 20
          
          sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf
          #echo 'http://salt/fifo-old/' >> /opt/local/etc/pkgin/repositories.conf
          #echo 'http://pkgsrc.joyent.com/packages/SmartOS/2014Q4/x86_64/All' >> /opt/local/etc/pkgin/repositories.conf

          zfs set mountpoint=/data zones/$(zonename)/data
          
          cd /data
          curl -O http://pkgs.briphant.com/pkgsrc-fifo.bak/fifo.gpg
          gpg --primary-keyring /opt/local/etc/gnupg/pkgsrc.gpg --import < fifo.gpg
          gpg --keyring /opt/local/etc/gnupg/pkgsrc.gpg --fingerprint

        
          #pkgin -y install fifo-snarl fifo-sniffle fifo-howl fifo-cerberus
          cd /root
          #pkg_add -U ./unixodbc-2.3.0nb2.tgz
          #pkg_add -U ./perl-5.20.1.tgz
          pkg_add -U ./erlang-18.0nb1.tgz
          pkg_add -U ./fifo-snarl-0.7.0p6.tgz
          pkg_add -U ./fifo-howl-0.7.0p1.tgz 
          pkg_add -U ./fifo-sniffle-0.7.0p7.tgz
          pkg_add -U ./fifo-cerberus-0.7.0p9.tgz
          svcadm enable epmd
          svcadm enable snarl
          svcadm enable sniffle
          svcadm enable howl
          sleep 60
          svcs epmd snarl sniffle howl
          
    old_fifo_0_7_home_2:
       salt_target: no-minion
       image_uuid: 1bd84670-055a-11e5-aaa2-0346bb21d5a1
       name: old_fifo_0_7_home_2
       version: 2.0
       description: old_fifo_0_7_home_2
       os: smartos
       type: zone-dataset
       max_physical_memory: 3072
       ip: 10.0.1.196
       gateway: 10.0.1.1
       customer_metadata: "/usr/bin/sed  -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          unixodbc-2.3.0nb2.tgz: 'http://10.0.1.38/fifo-old/unixodbc-2.3.0nb2.tgz'
          perl-5.20.1.tgz: 'http://10.0.1.38/fifo-old/perl-5.20.1.tgz'
          chunter-0.7.0p4.gz: 'http://10.0.1.38/fifo-0.7.0/chunter-0.7.0p4.gz'          
          fifo-snarl-0.7.0.tgz: 'http://10.0.1.38/fifo-0.7.0/fifo-snarl-0.7.0.tgz'
          fifo-snarl-0.7.0p6.tgz: 'http://10.0.1.38/fifo-0.7.0/fifo-snarl-0.7.0p6.tgz'
          fifo-howl-0.7.0.tgz: 'http://10.0.1.38/fifo-0.7.0/fifo-howl-0.7.0.tgz'
          fifo-howl-0.7.0p1.tgz: 'http://10.0.1.38/fifo-0.7.0/fifo-howl-0.7.0p1.tgz'
          fifo-sniffle-0.7.0.tgz: 'http://10.0.1.38/fifo-0.7.0/fifo-sniffle-0.7.0.tgz'
          fifo-sniffle-0.7.0p7.tgz: 'http://10.0.1.38/fifo-0.7.0/fifo-sniffle-0.7.0p7.tgz'
          fifo-cerberus-0.7.0p9.tgz: 'http://10.0.1.38/fifo-0.7.0/fifo-cerberus-0.7.0p9.tgz'
          erlang-18.0nb1.tgz: 'http://10.0.1.38/fifo-old/erlang-18.0nb1.tgz'


       dataset_install_script: |
          #set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")       
 
          route delete default 10.0.1.1
          route add  default 10.0.1.101
          netstat -r

          #install salt
          echo '10.0.1.38 salt'>>/etc/hosts;sed -i.bak2 '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://salt/smartos/pkgin2014Q4/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;salt-minion -d ;sleep 20
          
          sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf
          #echo 'http://salt/fifo-old/' >> /opt/local/etc/pkgin/repositories.conf
          #echo 'http://pkgsrc.joyent.com/packages/SmartOS/2014Q4/x86_64/All' >> /opt/local/etc/pkgin/repositories.conf

          zfs set mountpoint=/data zones/$(zonename)/data
          
          cd /data
          curl -O http://pkgs.briphant.com/pkgsrc-fifo.bak/fifo.gpg
          gpg --primary-keyring /opt/local/etc/gnupg/pkgsrc.gpg --import < fifo.gpg
          gpg --keyring /opt/local/etc/gnupg/pkgsrc.gpg --fingerprint

        
          #http://pkgsrc.joyent.com:80/packages/SmartOS/2014Q4/x86_64/All  
          #http://pkgs.briphant.com/pkgsrc-joyent/SmartOS/2014Q4/x86_64/All/
          #pkgin -y install fifo-snarl fifo-sniffle fifo-howl fifo-cerberus
          cd /root
          #pkg_add -U ./unixodbc-2.3.0nb2.tgz
          #pkg_add -U ./perl-5.20.1.tgz
          #pkg_add -U ./erlang-18.0nb1.tgz
          pkg_add -U ./fifo-snarl-0.7.0p6.tgz
          pkg_add -U ./fifo-howl-0.7.0p1.tgz 
          pkg_add -U ./fifo-sniffle-0.7.0p7.tgz
          pkg_add -U ./fifo-cerberus-0.7.0p9.tgz
          svcadm enable epmd
          svcadm enable snarl
          svcadm enable sniffle
          svcadm enable howl
          sleep 60
          svcs epmd snarl sniffle howl

          /opt/local/fifo-sniffle/bin/sniffle-admin cluster join 'sniffle@10.0.1.19'
          /opt/local/fifo-sniffle/bin/sniffle-admin cluster plan
          /opt/local/fifo-sniffle/bin/sniffle-admin cluster commit
          
          /opt/local/fifo-howl/bin/howl-admin cluster join 'howl@10.0.1.19'
          /opt/local/fifo-howl/bin/howl-admin cluster plan
          /opt/local/fifo-howl/bin/howl-admin cluster commit
          
          /opt/local/fifo-snarl/bin/snarl-admin cluster join 'snarl@10.0.1.19'
          /opt/local/fifo-snarl/bin/snarl-admin cluster plan
          /opt/local/fifo-snarl/bin/snarl-admin   cluster commit
          
          sleep 10

          /opt/local/fifo-snarl/bin/snarl-admin member-status
          /opt/local/fifo-sniffle/bin/sniffle-admin member-status
          /opt/local/fifo-howl/bin/howl-admin member-status
          
          #snarl-admin init default MyOrg Users admin admin
          #sniffle-admin init-leofs 10.0.1.80.xip.io
          #svcadm restart sniffle
   


    
    new_fifo_home_8_2:
       salt_target: no-minion
       image_uuid: 1bd84670-055a-11e5-aaa2-0346bb21d5a1
       name: new_fifo_home_8_2
       version: 2.0
       description: new_fifo_home_8_2
       os: smartos
       type: zone-dataset
       max_physical_memory: 3072
       ip: 10.0.1.196
       gateway: 10.0.1.1
       customer_metadata: "/usr/bin/sed  -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          chunter-0.8.2p5.gz: 'http://10.0.1.38/fifo-0.8.2/chunter-0.8.2p5.gz'
          fifo-howl-0.8.2p4.tgz: 'http://10.0.1.38/fifo-0.8.2/fifo-howl-0.8.2p4.tgz'
          fifo-snarl-0.8.2p1.tgz: 'http://10.0.1.38/fifo-0.8.2/fifo-snarl-0.8.2p1.tgz'
          fifo-sniffle-0.8.2p4.tgz: 'http://10.0.1.38/fifo-0.8.2/fifo-sniffle-0.8.2p4.tgz'
          fifo-cerberus-0.8.2p2.tgz: 'http://10.0.1.38/fifo-0.8.2/fifo-cerberus-0.8.2p2.tgz'

       dataset_install_script: |
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")       
 

          #install salt
          echo '10.0.1.38 salt'>>/etc/hosts;sed -i.bak2 '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://salt/smartos/pkgin2014Q4/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;salt-minion -d ;sleep 20
          
          sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf
          #echo 'http://salt/fifo-old/' >> /opt/local/etc/pkgin/repositories.conf
          #echo 'http://pkgsrc.joyent.com/packages/SmartOS/2014Q4/x86_64/All' >> /opt/local/etc/pkgin/repositories.conf

          zfs set mountpoint=/data zones/$(zonename)/data
          
          cd /data
          curl -O http://pkgs.briphant.com/pkgsrc-fifo.bak/fifo.gpg
          gpg --primary-keyring /opt/local/etc/gnupg/pkgsrc.gpg --import < fifo.gpg
          gpg --keyring /opt/local/etc/gnupg/pkgsrc.gpg --fingerprint

        
          #pkgin -y install fifo-snarl fifo-sniffle fifo-howl fifo-cerberus
          cd /root
          #pkg_add -U ./unixodbc-2.3.0nb2.tgz
          #pkg_add -U ./perl-5.20.1.tgz
          #pkg_add -U ./erlang-18.0nb1.tgz
          pkg_add -U ./fifo-snarl-0.8.2p1.tgz
          pkg_add -U ./fifo-howl-0.8.2p4.tgz 
          pkg_add -U ./fifo-sniffle-0.8.2p4.tgz
          pkg_add -U ./fifo-cerberus-0.8.2p2.tgz
          #svcadm enable epmd
          #svcadm enable snarl
          #svcadm enable sniffle
          #svcadm enable howl
          #sleep 60
          #svcs epmd snarl sniffle howl


    leofs1_thinkpad:
       salt_target: no-minion
       image_uuid: 1bd84670-055a-11e5-aaa2-0346bb21d5a1
       name: leofs1_thinkpad
       version: 2.0
       description: leofs1_thinkpad
       os: smartos
       type: zone-dataset
       max_physical_memory: 5120
       ip: 192.168.1.80
       gateway: 192.168.1.1
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          leo_manager.conf.bak: 'http://192.168.1.128/file-share/leo_manager.conf.leofs_1'
          leo_gateway.conf.bak: 'http://192.168.1.128/file-share/leo_gateway.conf.leofs_1'
          leo_storage.conf.bak: 'http://192.168.1.128/file-share/leo_storage.conf.leofs_1'
          
       dataset_install_script: |
          #set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")                 
          sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf

          curl -O https://project-fifo.net/fifo.gpg
          gpg --primary-keyring /opt/local/etc/gnupg/pkgsrc.gpg --import < /root/fifo.gpg
          gpg --keyring /opt/local/etc/gnupg/pkgsrc.gpg --fingerprint
          
          VERSION=rel
          cp /opt/local/etc/pkgin/repositories.conf /opt/local/etc/pkgin/repositories.conf.original
          sed -i.bak  '$d' /opt/local/etc/pkgin/repositories.conf
          echo "http://192.168.1.128/fifo-leofs-for-minimal-64-lts-14.4.2/" >> /opt/local/etc/pkgin/repositories.conf
          rm -fr /var/db/pkgin/*
          pkgin -fy up
          pkgin -y install coreutils sudo gawk gsed
          pkgin -y install leo_manager leo_gateway leo_storage
          
          cp  /opt/local/leo_manager/etc/leo_manager.conf  /opt/local/leo_manager/etc/leo_manager.conf.original
          cp  /opt/local/leo_gateway/etc/leo_gateway.conf  /opt/local/leo_gateway/etc/leo_gateway.conf.original
          cp  /opt/local/leo_storage/etc/leo_storage.conf  /opt/local/leo_storage/etc/leo_storage.conf.original
          
          mv -f /root/leo_manager.conf    /opt/local/leo_manager/etc/leo_manager.conf
          mv -f /root/leo_gateway.conf    /opt/local/leo_gateway/etc/leo_gateway.conf
          mv -f /root/leo_storage.conf    /opt/local/leo_storage/etc/leo_storage.conf
          
          
          mv -f /opt/local/etc/pkgin/repositories.conf.original  /opt/local/etc/pkgin/repositories.conf
          
          
          svcadm enable epmd
          svcadm enable leofs/manager
          svcadm enable leofs/storage
          sleep 3
          leofs-adm status
          leofs-adm start
          sleep 3
          svcadm enable leofs/gateway
          leofs-adm status
          
          #sed -i.bak2  '$d' /opt/local/etc/pkgin/repositories.conf
          #echo '10.75.1.70 salt'>>/etc/hosts;sed -i.bak2 '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          #echo abc       

      

    leofs2_thinkpad:
       salt_target: no-minion
       image_uuid: 1bd84670-055a-11e5-aaa2-0346bb21d5a1
       name: leofs1_thinkpad
       version: 2.0
       description: leofs2_thinkpad
       os: smartos
       type: zone-dataset
       max_physical_memory: 1024
       ip: 192.168.1.81
       gateway: 192.168.1.1
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          leo_manager.conf.bak: 'http://192.168.1.128/file-share/leo_manager.conf.leofs_2'
   
       dataset_install_script: |
          #set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")                 
          sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf

          curl -O https://project-fifo.net/fifo.gpg
          gpg --primary-keyring /opt/local/etc/gnupg/pkgsrc.gpg --import < /root/fifo.gpg
          gpg --keyring /opt/local/etc/gnupg/pkgsrc.gpg --fingerprint
          
          VERSION=rel
          cp /opt/local/etc/pkgin/repositories.conf /opt/local/etc/pkgin/repositories.conf.original
          sed -i.bak  '$d' /opt/local/etc/pkgin/repositories.conf
          echo "http://192.168.1.128/fifo-leofs-for-minimal-64-lts-14.4.2/" >> /opt/local/etc/pkgin/repositories.conf
          rm -fr /var/db/pkgin/*
          pkgin -fy up
          pkgin -y install coreutils sudo gawk gsed
          pkgin -y install leo_manager leo_gateway leo_storage
          
          cp  /opt/local/leo_manager/etc/leo_manager.conf  /opt/local/leo_manager/etc/leo_manager.conf.original
          mv -f /root/leo_manager.conf    /opt/local/leo_manager/etc/leo_manager.conf
          
          mv -f /opt/local/etc/pkgin/repositories.conf.original  /opt/local/etc/pkgin/repositories.conf
          
          svcadm enable epmd
          svcadm enable leofs/manager
          
          #sed -i.bak2  '$d' /opt/local/etc/pkgin/repositories.conf
          #echo '10.75.1.70 salt'>>/etc/hosts;sed -i.bak2 '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          #echo abc          

          #echo '10.75.1.70 salt'>>/etc/hosts;sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          #echo abc             
          
          


    briphant_cloud_beijing_1:
       salt_target: beijing_office
       image_uuid: 70e3ae72-96b6-11e6-9056-9737fd4d0764
       name: briphant_cloud_beijing_1
       version: 2.0
       description: briphant_cloud_beijing_1
       os: smartos
       type: zone-dataset
       max_physical_memory: 5120
       ip: 10.20.2.86
       gateway: 10.20.2.1
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          deploy.sh: 'http://10.20.5.23/cloud/b-dev/howl/fifo_howl_0.9.2_b-dev_115.tgz'
       dataset_install_script: |
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")       
          sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf
          #
          echo '10.20.2.200 salt'>>/etc/hosts;sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://salt/smartos/pkgin2016Q3' >> /opt/local/etc/pkgin/repositories.conf;echo 'http://salt/salt-2016Q3/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          zfs set mountpoint=/data zones/$(zonename)/data

          #wget --quiet -O /root/deploy.sh             http://192.168.10.56:5000/cloud/deploy-script/raw/master/deploy.sh
          wget --quiet -O /root/fifo_howl.tgz          http://10.20.5.23/cloud/v7.1.0/howl/fifo_howl_0.9.2_v7.1.0_27.tgz
          wget --quiet -O /root/fifo_snarl.tgz         http://10.20.5.23/cloud/v7.1.0/snarl/fifo_snarl_0.9.2_v7.1.0_26.tgz
          wget --quiet -O /root/fifo_sniffle.tgz       http://10.20.5.23/cloud/v7.1.0/sniffle/fifo_sniffle_0.9.2_v7.1.0_16.tgz
          wget --quiet -O /root/flowerrain_release.tgz http://10.20.5.23/cloud/v7.1.0/flowerrain/flowerrain_v7.1.0_44.tgz
          #wget --quiet -O /root/chunter.gz            http://10.20.5.23/cloud/release20161031/chunter/chunter_0.8.3_release20161031_5.gz
 
          pkgin -y install   erlang nginx
          mkdir -p /opt/pkg/
          #cp /root/*.tgz  /opt/pkg/
          #chmod +x /root/deploy.sh
          
          pkg_add -U /root/fifo_howl.tgz 
          pkg_add -U /root/fifo_snarl.tgz 
          pkg_add -U /root/fifo_sniffle.tgz
          
          mkdir -p /opt/local/www
          tar xvf /root/flowerrain_release.tgz -C /opt/local/www
          mkdir /opt/local/etc/nginx/includes
          cp /opt/local/www/flower.conf /opt/local/etc/nginx/includes

          #snarl-admin init default MyOrg Users admin admin
          #sniffle-admin init-leofs 10.20.2.130.xip.io
          #svcadm restart sniffle
          #sleep 10
          #svcs epmd snarl sniffle howl
          #sniffle-admin config show

          #install nginx
          #sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.128/smartos/pkgin2014Q4/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up
          #pkgin install nginx;svcadm enable svc:/pkgsrc/nginx:default
          #cp /opt/local/etc/nginx/nginx.conf /opt/local/etc/nginx/nginx.conf.bak
          
          mkdir -p /opt/local/www/
          #wget --quiet -O /opt/local/etc/nginx/nginx.conf http://192.168.1.128/file-share/briphant_cloud_flowerrain_nginx.conf         
          #wget --quiet -O /opt/local/etc/nginx/flower.conf http://192.168.1.128/file-share/briphant_cloud_flowerrain-flower.conf
          #cd /opt/local/www/;tar -xvzf ./flowerrain_release.tgz
          
          #install salt
          #echo '10.75.1.70 salt'>>/etc/hosts;sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          #echo abc


    briphant_cloud_alpha_test_2:
       salt_target: no-minion
       image_uuid: 1bd84670-055a-11e5-aaa2-0346bb21d5a1
       name: briphant_cloud_alpha_test_2
       version: 2.0
       description: briphant_cloud_alpha_test_2
       os: smartos
       type: zone-dataset
       max_physical_memory: 5120
       ip: 10.75.1.87
       gateway: 10.75.1.1
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          deploy.sh: 'http://192.168.1.128/file-share/deploy.sh'
       dataset_install_script: |
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")       
          sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf
          
          #wget --quiet -O /root/deploy.sh    http://192.168.10.56:5000/cloud/deploy-script/raw/master/deploy.sh
          wget --quiet -O /root/fifo_howl.tgz  http://10.20.5.23/cloud/release20161031/howl/fifo_howl_0.8.2_release20161031_10.tgz
          wget --quiet -O /root/fifo_snarl.tgz     http://10.20.5.23/cloud/release20161031/snarl/fifo_snarl_0.8.2_release20161031_7.tgz
          wget --quiet -O /root/fifo_sniffle.tgz   http://10.20.5.23/cloud/release20161031/sniffle/fifo_sniffle_0.8.3_release20161031_3.tgz
          wget --quiet -O /root/flowerrain_release.tgz http://10.20.5.23/cloud/release20161031/flowerrain/flowerrain_release20161031_1.tgz
          
          
          mkdir -p /opt/pkg/
          cp /root/*.tgz  /opt/pkg/
          chmod +x /root/deploy.sh
          
          #echo '10.75.1.70 salt'>>/etc/hosts;sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          #echo abc
                


    briphant_cloud_alpha_test_3:
       salt_target: no-minion
       image_uuid: 1bd84670-055a-11e5-aaa2-0346bb21d5a1
       name: briphant_cloud_alpha_test_3
       version: 2.0
       description: briphant_cloud_alpha_test_3
       os: smartos
       type: zone-dataset
       max_physical_memory: 5120
       ip: 10.75.1.88
       gateway: 10.75.1.1
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          deploy.sh: 'http://192.168.1.128/file-share/deploy.sh'
       dataset_install_script: |
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")       
          sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf
          
          #wget --quiet -O /root/deploy.sh    http://192.168.10.56:5000/cloud/deploy-script/raw/master/deploy.sh
          wget --quiet -O /root/fifo_howl.tgz  http://10.20.5.23/cloud/release20161031/howl/fifo_howl_0.8.2_release20161031_10.tgz
          wget --quiet -O /root/fifo_snarl.tgz     http://10.20.5.23/cloud/release20161031/snarl/fifo_snarl_0.8.2_release20161031_7.tgz
          wget --quiet -O /root/fifo_sniffle.tgz   http://10.20.5.23/cloud/release20161031/sniffle/fifo_sniffle_0.8.3_release20161031_3.tgz
          wget --quiet -O /root/flowerrain_release.tgz http://10.20.5.23/cloud/release20161031/flowerrain/flowerrain_release20161031_1.tgz
          
          mkdir -p /opt/pkg/
          cp /root/*.tgz  /opt/pkg/
          chmod +x /root/deploy.sh
          
          #echo '10.75.1.70 salt'>>/etc/hosts;sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          #echo abc
                

    NSQ_briphant_cloud_alpha_test:
       salt_target: no-minion
       image_uuid: 1bd84670-055a-11e5-aaa2-0346bb21d5a1
       name: NSQ_briphant_cloud_alpha_test
       version: 2.0
       description: NSQ_briphant_cloud_alpha_test
       os: smartos
       type: zone-dataset
       max_physical_memory: 2048
       ip: 10.75.1.90
       gateway: 10.75.1.1
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          mustang_local.sh: 'http://192.168.1.128/file-share/mustang.sh'
         
       dataset_install_script: |
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")       
          sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf
          /root/mustang.sh mustang_master_962.tar.gz
          #/root/install_taurus.sh
          
          #sh /root/install_aries.sh
          #sh /root/install_lobster.sh
          #sh /root/install_giraffe.sh
          #sh /root/install_nsq.sh
          #sh /root/install_rabbitmq.sh
          #sh /root/install_monkey.sh

          #sh /root/install_python.sh
          #sh install_python_wu.sh
          #echo '10.75.1.70 salt'>>/etc/hosts;sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          #echo abc          
                
    Tachyon_Aggregator_briphant_cloud_alpha_test:
       salt_target: no-minion
       image_uuid: 1bd84670-055a-11e5-aaa2-0346bb21d5a1
       name: Tachyon_Aggregator_briphant_cloud_alpha_test
       version: 2.0
       description: Tachyon_Aggregator_briphant_cloud_alpha_test
       os: smartos
       type: zone-dataset
       max_physical_memory: 2048
       ip: 10.75.1.91
       gateway: 10.75.1.1
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          mustang_local.sh: 'http://192.168.1.128/file-share/mustang.sh'
         
       dataset_install_script: |
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")       
          sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf
          /root/mustang.sh mustang_master_962.tar.gz
          #/root/install_taurus.sh
          
          #sh /root/install_aries.sh
          #sh /root/install_lobster.sh
          #sh /root/install_giraffe.sh
          #sh /root/install_nsq.sh
          #sh /root/install_rabbitmq.sh
          #sh /root/install_monkey.sh

          #sh /root/install_python.sh
          #sh install_python_wu.sh
          #echo '10.75.1.70 salt'>>/etc/hosts;sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          #echo abc    



    DalmatinerDB_briphant_cloud_alpha_test:
       salt_target: no-minion
       image_uuid: 1bd84670-055a-11e5-aaa2-0346bb21d5a1
       name: DalmatinerDB_briphant_cloud_alpha_test
       version: 2.0
       description: DalmatinerDB_briphant_cloud_alpha_test
       os: smartos
       type: zone-dataset
       max_physical_memory: 2048
       ip: 10.75.1.92
       gateway: 10.75.1.1
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          mustang_local.sh: 'http://192.168.1.128/file-share/mustang.sh'
         
       dataset_install_script: |
          set -e
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name")       
          sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf
          /root/mustang.sh mustang_master_962.tar.gz
          #/root/install_taurus.sh
          
          #sh /root/install_aries.sh
          #sh /root/install_lobster.sh
          #sh /root/install_giraffe.sh
          #sh /root/install_nsq.sh
          #sh /root/install_rabbitmq.sh
          #sh /root/install_monkey.sh

          #sh /root/install_python.sh
          #sh install_python_wu.sh
          #echo '10.75.1.70 salt'>>/etc/hosts;sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          #echo abc                    