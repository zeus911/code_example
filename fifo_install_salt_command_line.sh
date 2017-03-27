#!/bin/bash
set -e

#salt -L  'home_fifo,home_fifo2'   cmd.run      'svcadm restart snarl '
#salt -L  'home_fifo,home_fifo2'   cmd.run      'svcadm restart sniffle '
#salt -L  'home_fifo,home_fifo2'   cmd.run      'svcadm restart howl'


salt-run manage.down removekeys=True
salt '*' saltutil.refresh_pillar
salt home-smartos.wu state.sls_id   create_home_fifo2_vm        create_fifo_vm  -t 600
salt home-smartos.wu state.sls_id   dataset_install_home_fifo2    config_smartos_vm -t 3600
