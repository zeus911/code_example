cd /opt
# curl -O http://release.project-fifo.net/gz/dev/tachyon-meter-latest.gz
wget -O /opt/tachyon-meter-latest.gz  http://192.168.1.128/file-share/tachyon-meter-latest.gz
gunzip tachyon-meter-latest.gz
sh tachyon-meter-latest
#vim /opt/tachyon-meter/etc/tachyon.conf

cd /opt/tachyon-meter/etc
    
svcadm enable tachyon-meter
svcs tachyon-meter
