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


#cmd: echo {\"server\":\"`cat  /var/ssh/ssh_host_rsa_key.pub | cut -f -2 -d " "`\"  ,  \"client\":\"`cat /root/.ssh/id_rsa.pub 2>/dev/null`\"}|json
#salt jinhao  state.sls set_ssh_known_hosts                       #json server:  cat  /var/ssh/ssh_host_rsa_key.pub | cut -f -2 -d " "`\"  
#salt datasets.dsapid sate.sls set_ssh_authorized_keys            #json client:  cat /root/.ssh/id_rsa.pub 2>/dev/null