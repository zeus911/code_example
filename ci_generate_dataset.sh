#!/bin/bash
#salt '*'  mine.flush

salt '*' saltutil.refresh_pillar
#salt -L 'smartos_thinkpad.zhixiang'   cmd.run 'ssh-keygen -f /root/.ssh/id_rsa -t rsa -N ""' 
salt -L 'smartos_thinkpad.zhixiang,ocp09.thu.briphant.com'   cmd.run 'vmadm list | grep  dataset_test_  | awk "{print \$1}" |xargs -I {} vmadm delete {}'
salt smartos_thinkpad.zhixiang  cmd.run 'rm -fr /var/tmp/*'
salt-run manage.down removekeys=True
salt '*'  mine.update
salt -L 'ocp09.thu.briphant.com,smartos_thinkpad.zhixiang,dataset_test_kvm' state.sls set_ssh_known_hosts
salt-run state.orchestrate  mustang  
