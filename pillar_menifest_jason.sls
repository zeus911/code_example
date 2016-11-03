

dataset_repository:
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
       salt_target: ocp09.thu.briphant.com
       image_uuid: 07b33b7a-27a3-11e6-816f-df7d94eea009
       name: aerospike-server
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

          
    vpnservice:
       salt_target: no-minion
       image_uuid: 74be319f-2753-4b0a-8ee2-514249dc3935
       name: native_zone_jinhao_vpn
       version: 2.0
       description: native_zone_jinhao_vpn
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
       salt_target: no-minion
       image_uuid: dd31507e-031e-11e6-be8a-8f2707b5b3ee
       name: kvm-test
       version: 2.0
       description: used-for-generating-lx-dataset
       os: smartos
       type: zvol
       max_physical_memory: 5120
       ip: 10.75.1.3
       gateway: 10.75.1.1
       customer_metadata: "NULL"
       programm_files:
          install_EMS.sh: 'http://192.168.10.56:5000/devops/megatron/raw/master/EMS/install.sh'
       dataset_install_script: |       
          log_file_name=dataset_install_`date +%F-%H_%M`.log
          exec &> >(tee "/root/$log_file_name") 
          echo abc

         
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
       salt_target: ocp12.thu.briphant.com
       image_uuid: 13f711f4-499f-11e6-8ea6-2b9fb858a619
       name: alpha_test_leofs1
       version: 2.0
       description: alpha_test_leofs1
       os: smartos
       type: zone-dataset
       max_physical_memory: 5120
       ip: 10.75.1.80
       gateway: 10.75.1.1
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          fifo_test.gpg: 'http://192.168.1.128/file-share/mustang.sh'
   
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
          echo "http://192.168.1.128/fifo-leofs/" >> /opt/local/etc/pkgin/repositories.conf
          rm -fr /var/db/pkgin/*
          pkgin -fy up
          pkgin -y install coreutils sudo gawk gsed
          pkgin -y install leo_manager leo_gateway leo_storage
          
          mv -f /opt/local/etc/pkgin/repositories.conf.original  /opt/local/etc/pkgin/repositories.conf
          sed -i.bak2  '$d' /opt/local/etc/pkgin/repositories.conf
          echo '10.75.1.70 salt'>>/etc/hosts;sed -i.bak2 '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          #echo abc       

      

    alpha_test_leofs2:
       salt_target: ocp12.thu.briphant.com
       image_uuid: 13f711f4-499f-11e6-8ea6-2b9fb858a619
       name: alpha_test_leofs2
       version: 2.0
       description: alpha_test_leofs2
       os: smartos
       type: zone-dataset
       max_physical_memory: 5120
       ip: 10.75.1.81
       gateway: 10.75.1.1
       customer_metadata: "/opt/local/bin/sed -i.bak 's/PermitRootLogin without-password/PermitRootLogin yes/g'   /etc/ssh/sshd_config; /usr/sbin/svcadm restart svc:/network/ssh:default"
       programm_files:
          fifo_test.gpg: 'http://192.168.1.128/file-share/mustang.sh'
   
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
          echo "http://192.168.1.128/fifo-leofs/" >> /opt/local/etc/pkgin/repositories.conf
          rm -fr /var/db/pkgin/*
          pkgin -fy up
          pkgin -y install coreutils sudo gawk gsed
          pkgin -y install leo_manager leo_gateway leo_storage
          
          mv -f /opt/local/etc/pkgin/repositories.conf.original  /opt/local/etc/pkgin/repositories.conf
          sed -i.bak2  '$d' /opt/local/etc/pkgin/repositories.conf
          echo '10.75.1.70 salt'>>/etc/hosts;sed -i.bak2 '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          #echo abc          

          #echo '10.75.1.70 salt'>>/etc/hosts;sed -i.bak '$d' /opt/local/etc/pkgin/repositories.conf;echo 'http://192.168.1.128/smartos/pkgin2016Q2/' >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;svcadm enable svc:/pkgsrc/salt:minion;sleep 20
          #echo abc            
          