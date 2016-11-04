#!/bin/bash


#创建配置fifo服务虚拟机
#salt ocp12.thu.briphant.com state.sls_id   create_briphant_cloud_alpha_test_2_vm            create_fifo_vm     -t 600
#salt ocp12.thu.briphant.com state.sls_id   dataset_install_briphant_cloud_alpha_test_1      config_smartos_vm -t 1800


#创建配置leofs服务虚拟机
salt -L 'smartos_thinkpad.zhixiang,ocp12.thu.briphant.com'   cmd.run 'vmadm list | grep  alpha_test_leofs | awk "{print \$1}" |xargs -I {} vmadm delete {}'
salt-run manage.down removekeys=True
salt '*' saltutil.refresh_pillar
salt '*'  mine.flush

salt '*'  mine.update
salt -L 'ocp12.thu.briphant.com,ocp15.thu.briphant.com,smartos_thinkpad.zhixiang,dataset_test_kvm' state.sls set_ssh_known_hosts
salt -L 'datasets.dsapid,centos7-qinghua,ocp12.thu.briphant.com,ocp15.thu.briphant.com,smartos_thinkpad.zhixiang,dataset_test_kvm' state.sls set_ssh_authorized_keys

salt ocp12.thu.briphant.com state.sls_id   create_alpha_test_leofs1_vm        create_smartos_vm  -t 600
salt ocp12.thu.briphant.com state.sls_id    alpha_test_leofs1_config_master   config_leofs_vm


salt ocp12.thu.briphant.com state.sls_id   create_alpha_test_leofs2_vm         create_smartos_vm  -t 600
salt ocp12.thu.briphant.com state.sls_id   alpha_test_leofs2_config_slave      config_leofs_vm
#先启动第二台上的manager
salt ocp12.thu.briphant.com state.sls_id   dataset_install_alpha_test_leofs2   config_smartos_vm   -t 600
salt ocp12.thu.briphant.com state.sls_id   dataset_install_alpha_test_leofs1   config_smartos_vm   -t 600
