#salt    home-smartos.wu    cmd.script salt://script/chunter_install_salt.cmd.script.sh  
#!/bin/bash
set -e
log_file_name=chunter_install_`date +%F-%H_%M`.log
exec &> >(tee "/opt/$log_file_name")                 

        
#VERSION=rel
#cd /opt
#curl -O http://salt/chunter-fifo/fifo_zlogin-latest.gz 
#gunzip fifo_zlogin-latest.gz
#sh fifo_zlogin-latest


VERSION=rel
cd /opt
curl -O http://salt/fifo-0.7.0/chunter-0.7.0p4.gz
gunzip chunter-0.7.0p4.gz
sh chunter-0.7.0p4 


svcadm enable epmd
sleep 5
svcs epmd
#svcadm enable fifo/zlogin
#sleep 5
#svcs fifo/zlogin
svcadm enable chunter
sleep 5
svcs chunter
