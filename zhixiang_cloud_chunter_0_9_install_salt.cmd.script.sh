#salt    home-smartos.wu    cmd.script salt://script/chunter_install_salt.cmd.script.sh  
#salt   honeymoon.honeymoon   cmd.script salt://script/zhixiang_cloud_chunter_0_9_install_salt.cmd.script.sh -t 600
#sudo    salt-cp  lakala.wu   /srv/salt/script/chunter_install_salt.cmd.script.sh  /root/
#!/bin/bash

log_file_name=chunter_0.9.1_install_`date +%F-%H_%M`.log
exec &> >(tee "/opt/$log_file_name")                 
svcadm disable chunter
#set -e
#salt-run manage.down removekeys=True       
#zfs snapshot zones/opt@fifo-7.0-9.1-2017-4-26
 
VERSION=rel
cd /opt
rm -fr /opt/chunter/ /opt/fifo_zlogin/
rm -fr fifo_zlogin-latest.gz  chunter-latest fifo_zlogin-latest
curl -O http://salt/fifo-0.9.2/fifo_zlogin-latest.gz
gunzip fifo_zlogin-latest.gz
sh fifo_zlogin-latest

VERSION=rel
cd /opt
curl -o /opt/chunter-latest.gz  http://10.20.5.23/cloud/v7.1.0/chunter/fifo_chunter_0.9.2_v7.1.0_36.tgz
#http://10.20.5.23/cloud/v8.1.0/chunter/fifo_chunter_0.9.2_v8.1.0_40.gz
gunzip chunter-latest.gz
sh chunter-latest

cp  /opt/chunter/etc/chunter.conf  /opt/chunter.conf.bak
cp  /opt/chunter/etc/chunter.conf.example  /opt/chunter/etc/chunter.conf
address=`/opt/salt/bin/appdata/salt-2016.3.3.solaris-2_11-i86pc_64bit/salt-call --out=json  network.ip_addrs 2>&1 | grep -v WAR | json local[0]`
sed -i.bak s/127.0.0.1/$address/g /opt/chunter/etc/chunter.conf
sed -i  ''  's/libsnarl.instance = snarl/libsnarl.instance = wu_snarl/' /opt/chunter/etc/chunter.conf
sed -i  ''  's/libhowl.instance = howl/libhowl.instance = wu_howl/'    /opt/chunter/etc/chunter.conf
sed -i  ''  's/libsniffle.instance = sniffle/libsniffle.instance = wu_sniffle/'  /opt/chunter/etc/chunter.conf
svcadm enable epmd
sleep 5
svcs epmd
svcadm enable fifo/zlogin
sleep 5
svcs fifo/zlogin
svcadm enable chunter
sleep 5
svcs chunter

#svcadm disable fifo/zlogin
#svcadm clear  fifo/zlogin
#svcadm enable fifo/zlogin
#sleep 5
#svcs fifo/zlogin
#svcadm disable chunter
#svcadm clear  chunter
#svcadm enable chunter
#sleep 5
#svcs chunter zlogin chunter
