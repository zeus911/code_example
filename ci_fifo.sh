#!/bin/bash

#安装dsapid-server
#salt fifo-thinkpad.thinkpad  state.sls_id   create_dsapid_server_thinkpad_vm     create_dsapid-server_vm     -t 600
#salt fifo-thinkpad.thinkpad  state.sls_id   dataset_install_dsapid_server_thinkpad      config_smartos_vm -t 3600


#安装监控
#salt ocp15.thu.briphant.com state.sls_id   create_NSQ_briphant_cloud_alpha_test_vm            create_Tachyon_vm     -t 600
#salt ocp15.thu.briphant.com state.sls_id   create_Tachyon_Aggregator_briphant_cloud_alpha_test_vm         create_Tachyon_vm     -t 600

#创建配置fifo服务虚拟机
#salt ocp12.thu.briphant.com state.sls_id   create_briphant_cloud_alpha_test_1_vm            create_fifo_vm     -t 600
#salt ocp12.thu.briphant.com state.sls_id   dataset_install_briphant_cloud_alpha_test_1      config_smartos_vm -t 3600

#salt ocp15.thu.briphant.com state.sls_id   create_briphant_cloud_alpha_test_2_vm            create_fifo_vm     -t 600
#salt ocp15.thu.briphant.com state.sls_id   dataset_install_briphant_cloud_alpha_test_2      config_smartos_vm -t 1800

#创建配置leofs服务虚拟机
salt -L 'smartos_thinkpad.zhixiang,ocp12.thu.briphant.com'   cmd.run 'vmadm list | grep  alpha_test_leofs | awk "{print \$1}" |xargs -I {} vmadm delete {}'

#设置ssh信任关系
salt-run manage.down removekeys=True
salt '*' saltutil.refresh_pillar
salt '*'  mine.flush
salt '*'  mine.update
salt -L 'ocp09.thu.briphant.com,ocp12.thu.briphant.com,ocp15.thu.briphant.com,smartos_thinkpad.zhixiang,dataset_test_kvm' state.sls set_ssh_known_hosts
salt -L 'dsapid_server_thinkpad,datasets.dsapid,centos7-qinghua,ocp09.thu.briphant.com,ocp12.thu.briphant.com,ocp15.thu.briphant.com,smartos_thinkpad.zhixiang,dataset_test_kvm' state.sls set_ssh_authorized_keys
#创建和配置leofs
salt ocp12.thu.briphant.com state.sls_id   create_alpha_test_leofs1_vm        create_smartos_vm  -t 600
salt ocp12.thu.briphant.com state.sls_id    alpha_test_leofs1_config_master   config_leofs_vm


salt ocp12.thu.briphant.com state.sls_id   create_alpha_test_leofs2_vm         create_smartos_vm  -t 600
salt ocp12.thu.briphant.com state.sls_id   alpha_test_leofs2_config_slave      config_leofs_vm
#先启动第二台上的manager
salt ocp12.thu.briphant.com state.sls_id   dataset_install_alpha_test_leofs2   config_smartos_vm   -t 600
salt ocp12.thu.briphant.com state.sls_id   dataset_install_alpha_test_leofs1   config_smartos_vm   -t 600
