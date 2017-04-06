#!/bin/bash
set -e

#salt -L  'home_fifo,home_fifo2'   cmd.run      'svcadm restart snarl '
#salt -L  'home_fifo,home_fifo2'   cmd.run      'svcadm restart sniffle '
#salt -L  'home_fifo,home_fifo2'   cmd.run      'svcadm restart howl'
#salt jinhao  state.sls_id   create_dsapid_server_vm        create_smartos_vm  -t 600
#salt jinhao  state.sls_id   dataset_install_dsapid_server      config_smartos_vm -t 3600

#svcadm disable dsapid
#svcadm enable dsapid

salt -L 'hp'   cmd.run 'vmadm list | grep  old_fifo_home_1  | awk "{print \$1}" |xargs -I {} vmadm delete {}'

salt-run manage.down removekeys=True
salt '*' saltutil.refresh_pillar
#salt home-smartos.wu state.sls_id   create_home_fifo2_vm        create_fifo_vm  -t 600
#salt home-smartos.wu state.sls_id   dataset_install_home_fifo2    config_smartos_vm -t 3600

salt hp      state.sls_id   create_old_fifo_home_1_vm          create_fifo_vm  -t 600
salt hp      state.sls_id   dataset_install_old_fifo_home_1    config_smartos_vm -t 3600
