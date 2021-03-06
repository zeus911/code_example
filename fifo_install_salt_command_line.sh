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
salt -L jinhao   cmd.run "vmadm list  | grep fifo_.*_aio_9  | awk '{print $1 }' |xargs -I {} sh -c 'vmadm update {}   indestructible_delegated=false;vmadm delete {}'"


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


salt jinhao     state.sls_id   create_fifo_1_aio_9_1_home_vm          create_fifo_vm  -t 600
salt jinhao     state.sls_id   dataset_install_fifo_1_aio_9_1_home    config_smartos_vm -t 3600
#升级配置数据
salt fifo_1_aio_9_1_home state.sls config_fifo_zone



salt jinhao     state.sls_id   create_fifo_2_aio_9_1_home_vm          create_fifo_vm  -t 600
salt jinhao     state.sls_id   dataset_install_fifo_2_aio_9_1_home    config_smartos_vm -t 3600
#升级配置数据
salt fifo_2_aio_9_1_home state.sls config_fifo_zone
#迁移数据
salt jinhao    cmd.script salt://script/transfer_data_in_fifo_zone.sh shell='/bin/bash'

salt 'fifo_*_aio_9_1_home' cmd.run "svcadm enable epmd;svcadm enable snarl; svcadm enable howl;svcadm enable sniffle"
#salt 'fifo_*_aio_9_1_home' cmd.run "svcadm restart snarl; svcadm restart howl;svcadm restart sniffle"
#salt 'fifo_*_aio_9_1_home' cmd.run "svcadm disable snarl; svcadm disable howl;svcadm disable sniffle"
#salt 'fifo_*_aio_9_1_home' cmd.run "svcadm clear snarl; svcadm clear howl;svcadm clear sniffle"
#salt 'fifo_*_aio_9_1_home' cmd.run "svcadm enable snarl; svcadm enable howl;svcadm enable sniffle"

sleep 10
salt 'fifo_*_aio_9_1_home'  state.sls fifo_0_9_rsyslog5_conf_blockreplace
salt 'fifo_*_aio_9_1_home' cmd.run "svcs epmd snarl sniffle howl"
sleep 20
salt 'fifo_*_aio_9_1_home' cmd.run "howl-admin status;sniffle-admin status;snarl-admin status;"
salt 'fifo_*_aio_9_1_home' cmd.run "snarl-admin member-status;howl-admin member-status;sniffle-admin member-status"
