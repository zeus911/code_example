#!/bin/bash
set -e

#salt -L  'home_fifo,home_fifo2'   cmd.run      'svcadm restart snarl '
#salt -L  'home_fifo,home_fifo2'   cmd.run      'svcadm restart sniffle '
#salt -L  'home_fifo,home_fifo2'   cmd.run      'svcadm restart howl'
#salt jinhao  state.sls_id   create_dsapid_server_vm        create_smartos_vm  -t 600
#salt jinhao  state.sls_id   dataset_install_dsapid_server      config_smartos_vm -t 3600
#zlogin f8a0f6bc-cf39-43da-8448-80dae8072d91 salt-minion -d
#svcadm disable dsapid
#svcadm enable dsapid

#salt -L jinhao   cmd.run "vmadm list  | grep fifo_0_7_home  | awk '{print $1 }' |xargs -I {} sh -c 'vmadm update {}   indestructible_delegated=false;vmadm delete {}'"
salt -L honeymoon.honeymoon   cmd.run "vmadm list  | grep briphant_cloud_beijing_*  | awk '{print $1 }' |xargs -I {} sh -c 'vmadm update {}   indestructible_delegated=false;vmadm delete {}'"


salt-run manage.down removekeys=True
salt '*' saltutil.refresh_pillar
#salt home-smartos.wu state.sls_id   create_home_fifo2_vm        create_fifo_vm  -t 600
#salt home-smartos.wu state.sls_id   dataset_install_home_fifo2    config_smartos_vm -t 3600

#salt jinhao     state.sls_id   create_old_fifo_0_7_home_1_vm          create_fifo_vm  -t 600
#salt jinhao     state.sls_id   dataset_install_old_fifo_0_7_home_1    config_smartos_vm -t 3600
#
#salt jinhao      state.sls_id   create_old_fifo_0_7_home_2_vm          create_fifo_vm  -t 600
#salt jinhao      state.sls_id   dataset_install_old_fifo_0_7_home_2    config_smartos_vm -t 3600


#salt jinhao      state.sls_id   create_new_fifo_home_1_vm          create_fifo_vm  -t 600
#salt jinhao      state.sls_id   dataset_install_new_fifo_home_1    config_smartos_vm -t 3600

for fifo_zone_number in 1 2 3
do
salt honeymoon.honeymoon     state.sls_id   create_briphant_cloud_beijing_"$fifo_zone_number"_vm          create_fifo_vm  -t 600
salt honeymoon.honeymoon     state.sls_id   dataset_install_briphant_cloud_beijing_$fifo_zone_number    config_smartos_vm -t 3600
done
#升级配置数据
#salt fifo_1_aio_9_1_home state.sls config_fifo_zone



#salt jinhao     state.sls_id   create_fifo_2_aio_9_1_home_vm          create_fifo_vm  -t 600
#salt jinhao     state.sls_id   dataset_install_fifo_2_aio_9_1_home    config_smartos_vm -t 3600
#升级配置数据
#salt fifo_2_aio_9_1_home state.sls config_fifo_zone
#迁移数据
#salt jinhao    cmd.script salt://script/transfer_data_in_fifo_zone.sh shell='/bin/bash'

salt 'briphant_cloud_beijing_*' cmd.run "svcadm enable epmd;svcadm enable snarl; svcadm enable howl;svcadm enable sniffle"
#salt 'fifo_*_aio_9_1_home' cmd.run "svcadm restart snarl; svcadm restart howl;svcadm restart sniffle"
#salt 'briphant_cloud_beijing_*' cmd.run "svcadm disable snarl; svcadm disable howl;svcadm disable sniffle"
#salt 'briphant_cloud_beijing_*' cmd.run "svcadm enable snarl; svcadm enable howl;svcadm enable sniffle"
#salt 'fifo_*_aio_9_1_home' cmd.run "svcadm clear snarl; svcadm clear howl;svcadm clear sniffle"



sleep 30
          
          #/opt/local/fifo-howl/bin/howl-admin cluster join 'howl@10.0.1.85'
          #/opt/local/fifo-howl/bin/howl-admin cluster plan
          #/opt/local/fifo-howl/bin/howl-admin cluster commit
          #
          #/opt/local/fifo-snarl/bin/snarl-admin cluster join 'snarl@10.0.1.85'
          #/opt/local/fifo-snarl/bin/snarl-admin cluster plan
          #/opt/local/fifo-snarl/bin/snarl-admin   cluster commit

salt 'briphant_cloud_beijing_*' cmd.run "svcs epmd snarl sniffle howl"
#salt 'briphant_cloud_beijing_1' cmd.run "snarl-admin init default MyOrg Users admin admin"  -t 600
salt 'briphant_cloud_beijing_1' cmd.run "/opt/local/fifo-snarl/bin/snarl-init"  -t 600
sleep 30

for fifo_zone_number in 2 3
do
salt briphant_cloud_beijing_"$fifo_zone_number" cmd.run          "sniffle-admin cluster join 'sniffle@10.20.2.86';sleep 15;sniffle-admin cluster plan;sleep 10;sniffle-admin cluster commit" -t 600
salt briphant_cloud_beijing_"$fifo_zone_number" cmd.run          "snarl-admin cluster   join 'snarl@10.20.2.86';sleep 15;snarl-admin cluster plan;sleep 10;snarl-admin cluster commit" -t 600
salt briphant_cloud_beijing_"$fifo_zone_number" cmd.run          "howl-admin cluster    join 'howl@10.20.2.86';sleep 15;howl-admin cluster plan;sleep 10;howl-admin cluster commit" -t 600
done


 salt 'briphant_cloud_beijing_1' cmd.run "sniffle-admin    config set       storage.s3.access_key                               4218d530b9ff5b78214f" 
 salt 'briphant_cloud_beijing_1' cmd.run "sniffle-admin    config set       storage.s3.secret_key           5130e6a33a8b1db9b39bf2c4437eec7fb3d9b04c" 
 salt 'briphant_cloud_beijing_1' cmd.run "sniffle-admin    config set   storage.s3.general_bucket                                               fifo" 
 salt 'briphant_cloud_beijing_1' cmd.run "sniffle-admin    config set     storage.s3.image_bucket                                        fifo-images" 
 salt 'briphant_cloud_beijing_1' cmd.run "sniffle-admin    config set  storage.s3.snapshot_bucket                                       fifo-backups"
 salt 'briphant_cloud_beijing_1' cmd.run "sniffle-admin config show" 
 #salt 'briphant_cloud_beijing_1' cmd.run "sniffle-admin init-leofs 10.20.2.130.xip.io;svcs epmd snarl sniffle howl;sniffle-admin config show"
sleep 10
#rsyslog

salt 'briphant_cloud_beijing_*'  state.sls fifo_rsyslog7_conf_blockreplace
salt 'briphant_cloud_beijing_1' cmd.run "ls -ltr /data/*/log/"  shell='/bin/bash'




salt 'briphant_cloud_beijing_*'  state.single      file.managed  template=jinja name='/opt/local/etc/nginx/nginx.conf'   source='salt://file/nginx.conf.zhixiang_cloud'  backup='minion'
salt 'briphant_cloud_beijing_*'  state.single      file.managed  template=jinja name=' /opt/local/etc/nginx/includes/flower.conf'   source='salt://file/flower.conf.zhixiang_cloud'  backup='minion'
salt 'briphant_cloud_beijing_*'  cmd.run           "svcadm enable nginx"
sleep 30
salt 'briphant_cloud_beijing_1' cmd.run "howl-admin status;sniffle-admin status;snarl-admin status;"  -t 600
salt 'briphant_cloud_beijing_1' cmd.run "snarl-admin member-status;howl-admin member-status;sniffle-admin member-status"  -t 600