#salt    jinhao    cmd.script salt://script/chunter_0_7_install_salt.cmd.script.sh  -t 600
#sudo    salt-cp  lakala.wu   /srv/salt/script/chunter_0_7_install_salt.cmd.script.sh  /root/
#!/bin/bash
set -e
log_file_name=chunter_install_`date +%F-%H_%M`.log
exec &> >(tee "/opt/$log_file_name")                 
vmadm  list | grep 9_1 | awk '{print $1}' |xargs -I{} vmadm stop {}
#salt-run manage.down removekeys=True       
sleep 3
svcadm disable chunter
sleep 5
rm -rf chunter-0.7.0p3.gz
rm -fr /opt/chunter 
rm -fr /opt/chunter-0.7.0p3

#VERSION=rel
#cd /opt
#curl -O http://salt/chunter-fifo/fifo_zlogin-latest.gz 
#gunzip fifo_zlogin-latest.gz
#sh fifo_zlogin-latest


VERSION=rel
cd /opt
curl -O http://salt/fifo-0.7.0/chunter-0.7.0p3.gz
gunzip chunter-0.7.0p3.gz
yes 'yes' |sh chunter-0.7.0p3
cp /opt/chunter/etc/chunter.conf.example /opt/chunter/etc/chunter.conf
address=`/opt/salt/bin/appdata/salt-2016.3.3.solaris-2_11-i86pc_64bit/salt-call --out=json  network.ip_addrs 2>&1 | grep -v WAR | json local[0]`
sed -i.bak s/127.0.0.1/$address/g /opt/chunter/etc/chunter.conf

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
#vmadm  list | grep  old_fifo_0_7_home  | awk '{print $1}' |xargs -I{} vmadm start {}
