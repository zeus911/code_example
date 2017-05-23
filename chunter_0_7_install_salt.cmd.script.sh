#salt    home-smartos.wu    cmd.script salt://script/chunter_0_7_install_salt.cmd.script.sh  
#sudo    salt-cp  lakala.wu   /srv/salt/script/chunter_0_7_install_salt.cmd.script.sh  /root/
#!/bin/bash
set -e
log_file_name=chunter_install_`date +%F-%H_%M`.log
exec &> >(tee "/opt/$log_file_name")                 

#salt-run manage.down removekeys=True       

svcadm disable chunter
#VERSION=rel
#cd /opt
#curl -O http://salt/chunter-fifo/fifo_zlogin-latest.gz 
#gunzip fifo_zlogin-latest.gz
#sh fifo_zlogin-latest


VERSION=rel
cd /opt
curl -O http://salt/fifo-0.7.0/chunter-0.7.0p3.gz
gunzip chunter-0.7.0p3.gz
sh chunter-0.7.0p3
cp /opt/chunter/etc/chunter.conf.example /opt/chunter/etc/chunter.conf
sed -i.bak s/127.0.0.1/10.0.1.88/g /opt/chunter/etc/chunter.conf
sleep 5
svcadm enable epmd
sleep 5
svcs epmd
#svcadm enable fifo/zlogin
#sleep 5
#svcs fifo/zlogin
svcadm enable chunter
sleep 5
svcs epmd chunter
