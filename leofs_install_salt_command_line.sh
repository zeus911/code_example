#!/bin/bash
set -e
#安装监控
#salt ocp15.thu.briphant.com state.sls_id   create_NSQ_briphant_cloud_alpha_test_vm            create_Tachyon_vm     -t 600
#salt ocp15.thu.briphant.com state.sls_id   create_Tachyon_Aggregator_briphant_cloud_alpha_test_vm         create_Tachyon_vm     -t 600

#创建配置fifo服务虚拟机
#salt ocp12.thu.briphant.com state.sls_id   create_briphant_cloud_alpha_test_1_vm            create_fifo_vm     -t 600
#salt ocp12.thu.briphant.com state.sls_id   dataset_install_briphant_cloud_alpha_test_1      config_smartos_vm -t 3600

#salt ocp15.thu.briphant.com state.sls_id   create_briphant_cloud_alpha_test_2_vm            create_fifo_vm     -t 600
#salt ocp15.thu.briphant.com state.sls_id   dataset_install_briphant_cloud_alpha_test_2      config_smartos_vm -t 1800

#创建配置leofs服务虚拟机
#salt -L 'smartos_thinkpad.zhixiang,ocp12.thu.briphant.com'   cmd.run 'vmadm list | grep  alpha_test_leofs | awk "{print \$1}" |xargs -I {} vmadm delete {}'
#salt-run manage.down removekeys=True
#salt '*' saltutil.refresh_pillar
#salt '*'  mine.flush
#
#salt '*'  mine.update
#salt -L 'ocp12.thu.briphant.com,ocp15.thu.briphant.com,smartos_thinkpad.zhixiang,dataset_test_kvm' state.sls set_ssh_known_hosts
#salt -L 'datasets.dsapid,centos7-qinghua,ocp12.thu.briphant.com,ocp15.thu.briphant.com,smartos_thinkpad.zhixiang,dataset_test_kvm' state.sls set_ssh_authorized_keys
#
#salt ocp12.thu.briphant.com state.sls_id   create_alpha_test_leofs1_vm        create_smartos_vm  -t 600
#salt ocp12.thu.briphant.com state.sls_id    alpha_test_leofs1_config_master   config_leofs_vm
#
#
#salt ocp12.thu.briphant.com state.sls_id   create_alpha_test_leofs2_vm         create_smartos_vm  -t 600
#salt ocp12.thu.briphant.com state.sls_id   alpha_test_leofs2_config_slave      config_leofs_vm
##先启动第二台上的manager
#salt ocp12.thu.briphant.com state.sls_id   dataset_install_alpha_test_leofs2   config_smartos_vm   -t 600
#salt ocp12.thu.briphant.com state.sls_id   dataset_install_alpha_test_leofs1   config_smartos_vm   -t 600


salt  'cloud1*'   cmd.run 'vmadm list | grep  ci_beijing_office_leofs | awk "{print \$1}" |xargs -I {} vmadm delete {}'
salt-run manage.down removekeys=True
salt '*' saltutil.refresh_pillar

salt cloud17 state.sls_id   create_ci_beijing_office_leofs1_vm        create_smartos_vm  -t 600
salt cloud19 state.sls_id   create_ci_beijing_office_leofs2_vm        create_smartos_vm  -t 600
salt cloud17 state.sls_id   dataset_install_ci_beijing_office_leofs1    config_smartos_vm -t 3600
salt cloud19 state.sls_id   dataset_install_ci_beijing_office_leofs2    config_smartos_vm -t 3600

salt cloud17  state.sls_id    ci_beijing_office_leofs1_config_master     config_leofs_vm
salt cloud19  state.sls_id    ci_beijing_office_leofs2_config_slave      config_leofs_vm

#leofs1-manager:
salt ci_beijing_office_leofs1 cmd.run 'svcadm enable epmd' shell='/usr/bin/bash'
salt ci_beijing_office_leofs1 cmd.run 'svcadm enable leofs/manager' shell='/usr/bin/bash'
sleep 15
salt ci_beijing_office_leofs1 cmd.run 'svcs   leofs/manager'  shell='/usr/bin/bash'

#leofs2-manager:
salt ci_beijing_office_leofs2 cmd.run  'svcadm enable epmd'  shell='/usr/bin/bash'
salt ci_beijing_office_leofs2 cmd.run  'svcadm enable leofs/manager'  shell='/usr/bin/bash'
sleep 15
salt ci_beijing_office_leofs2 cmd.run  'svcs   leofs/manager'  shell='/usr/bin/bash'

#leofs1-storage:
salt ci_beijing_office_leofs1 cmd.run 'svcadm enable leofs/storage' shell='/usr/bin/bash'
sleep 15
salt ci_beijing_office_leofs1 cmd.run 'svcs   leofs/storage' shell='/usr/bin/bash'
salt ci_beijing_office_leofs1 cmd.run 'leofs-adm status' shell='/usr/bin/bash'
salt ci_beijing_office_leofs1 cmd.run 'leofs-adm start' shell='/usr/bin/bash'

salt ci_beijing_office_leofs1 cmd.run 'svcadm enable leofs/gateway' shell='/usr/bin/bash'
sleep 15
salt ci_beijing_office_leofs1 cmd.run 'svcs  leofs/storage leofs/manager leofs/gateway' shell='/usr/bin/bash'
salt ci_beijing_office_leofs1 cmd.run 'leofs-adm status'  shell='/usr/bin/bash'
