
salt -C 'cloud* and not cloud18'   cmd.run "imgadm import  c7ddb0a8-5fe0-11e7-b983-f305fb303725"  -t 1800
salt -C 'cloud* and not cloud18'   cmd.run "ps -ef | grep chunter"  -t 1800
salt -C 'cloud* and not cloud18'   cmd.run "pkill -f zlogin"  -t 1800

salt -C 'cloud* and not cloud18'   cmd.run "svcadm clear chunter;svcadm clear zlogin;svcadm clear epmd"  -t 1800
salt -C 'cloud* and not cloud18'   cmd.run "svcadm disable chunter;svcadm disable zlogin;svcadm disable epmd"  -t 1800
salt -C 'cloud* and not cloud18'   cmd.run "svcadm enable epmd;svcadm enable zlogin;svcadm enable chunter"  -t 1800

salt -C 'cloud* and not cloud18'   cmd.run "svcs chunter zlogin epmd"  -t 1800
salt   -C 'cloud* and not cloud18'    cmd.script salt://script/zhixiang_cloud_chunter_0_9_install_salt.cmd.script.sh -t 600



salt -C 'cloud* and not cloud18'   cmd.run "vmadm list| grep ci_cloud_beijing_ |awk '{print \$1}' |xargs -I {} sh -c 'echo {\\\"image_uuid\\\": \\\"c7ddb0a8-5fe0-11e7-b983-f305fb303725\\\"} | vmadm reprovision {}' "  -t 60
#salt -C 'cloud* and not cloud18'   cmd.run "vmadm list| grep ci_cloud_beijing_ |awk '{print \$1}' |xargs -I {} vmadm stop {}"



salt -C 'cloud* and not cloud18'   cmd.run "vmadm list| grep ci_cloud_beijing_ |awk '{print \$1}' |xargs -I {} zlogin {} sed -i.bak \\'\$ d\\' /opt/local/etc/pkgin/repositories.conf " -t 60
salt -C 'cloud* and not cloud18'   cmd.run "vmadm list| grep ci_cloud_beijing_ |awk '{print \$1}' |xargs -I {} zlogin {} cat /opt/local/etc/pkgin/repositories.conf " -t 60


salt-run manage.down removekeys=True


salt -C 'cloud* and not cloud18'   cmd.run "vmadm list| grep ci_cloud_beijing_ |awk '{print \$1}' |xargs -I {}  zlogin {} sh -c 'echo 10.20.2.200 salt>>/etc/hosts;echo http://192.168.31.12:8000/2016Q3/x86_64/All >> /opt/local/etc/pkgin/repositories.conf;echo http://salt/smartos/pkgin2016Q3 >> /opt/local/etc/pkgin/repositories.conf;rm -fr /var/db/pkgin/*;/opt/local/bin/pkgin -fy up;/opt/local/bin/pkgin -y install salt lrzsz;/usr/bin/hostname>/opt/local/etc/salt/minion_id;sleep 10;' " -t 600

salt -C 'cloud* and not cloud18'   cmd.run "vmadm list| grep ci_cloud_beijing_ |awk '{print \$1}' |xargs -I {}  zlogin {} svcs -a | grep salt"
salt -C 'cloud* and not cloud18'   cmd.run "vmadm list| grep ci_cloud_beijing_ |awk '{print \$1}' |xargs -I {}  zlogin {} svcadm enable svc:/pkgsrc/salt:minion"



##修改/data目录下的配置文件，因为是dataset delegate ，所以在global 生命周期内只要修改一次
#salt 'ci_cloud_beijing_*'  cmd.run "ls /data/*/etc/*.conf|xargs -I{} cp {} {}.bak3"
#salt 'ci_cloud_beijing_*' cmd.run  "sed -i.bak2  's/^service = howl/service = wu_howl/'  /data/howl/etc/howl.conf "
#salt 'ci_cloud_beijing_*' cmd.run  "sed -i.bak2  's/^service = snarl/service = wu_snarl/'  /data/snarl/etc/snarl.conf "
#salt 'ci_cloud_beijing_*' cmd.run  "sed -i.bak2  's/^service = sniffle/service = wu_sniffle/'  /data/sniffle/etc/sniffle.conf "
#
#salt 'ci_cloud_beijing_*'  cmd.run "sed -i.bak2  's/^libsnarl.instance = snarl/libsnarl.instance = wu_snarl/' /data/*/etc/*.conf"
#salt 'ci_cloud_beijing_*'  cmd.run "sed -i.bak2  's/^libhowl.instance = howl/libhowl.instance = wu_howl/'     /data/*/etc/*.conf"
#salt 'ci_cloud_beijing_*'  cmd.run "sed -i.bak2  's/^libsniffle.instance = sniffle/libsniffle.instance = wu_sniffle/'     /data/*/etc/*.conf"

salt 'ci_cloud_beijing_*'  cmd.run "sed -i.bak2  '/ldap_dataset/d' /data/*/etc/*.conf "
salt 'ci_cloud_beijing_*'  cmd.run "sed -i.bak2  '/create_res_g_pool/d' /data/*/etc/*.conf "
salt 'ci_cloud_beijing_*'  cmd.run "sed -i.bak2  '/nfs_dataset/d' /data/*/etc/*.conf "
##
salt ci_cloud_beijing_*  cmd.run "svcadm enable epmd;svcadm enable snarl; svcadm enable howl;svcadm enable sniffle"
#salt 'ci_cloud_beijing_*' cmd.run "svcadm restart snarl; svcadm restart howl;svcadm restart sniffle"
#salt ci_cloud_beijing_* cmd.run "svcadm clear snarl; svcadm clear howl;svcadm clear sniffle"

salt ci_cloud_beijing_*  cmd.run "svcs epmd snarl sniffle howl"
salt ci_cloud_beijing_*  cmd.run "mkdir -p /opt/local/etc/nginx/includes;cp /opt/local/www/flower.conf /opt/local/etc/nginx/includes"
salt 'ci_cloud_beijing_*'  state.single      file.managed  template=jinja name='/opt/local/etc/nginx/nginx.conf'   source='salt://file/nginx.conf.zhixiang_cloud'  backup='minion'
salt ci_cloud_beijing_*   state.single      file.managed  template=jinja name='/opt/local/etc/nginx/includes/flower.conf'   source='salt://file/flower.conf.zhixiang_cloud'  backup='minion'
salt ci_cloud_beijing_*   cmd.run           "svcadm enable nginx"
#salt 'ci_cloud_beijing_1' cmd.run "snarl-admin member-status;howl-admin member-status;sniffle-admin member-status"  -t 600

salt ci_cloud_beijing_*  state.sls fifo_0_9_rsyslog5_conf_blockreplace

salt -C 'cloud* and not cloud18'   cmd.run "svcs chunter"  -t 1800
