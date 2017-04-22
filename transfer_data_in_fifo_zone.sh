#!/bin/bash
set -e
# set -x
# grep  var/db   *.old | grep -v "abc"
# salt-cp jinhao ./upgrade_fifo_zone.sh /opt/
# salt  jinhao cmd.script salt://script/upgrade_fifo_zone.sh shell='/bin/bash'

svcadm disable chunter
vmadm list | grep old_fifo_0_7_home   |awk '{print $1}' |xargs -I {}  vmadm stop  {}
vmadm list | grep fifo_.*_aio_9_1_home|awk '{print $1}' |xargs -I {}  vmadm start {}

old_1=`vmadm list | grep old_fifo_0_7_home_1 |awk '{print $1}' `
new_1=`vmadm list | grep fifo_1_aio_9_1_home |awk '{print $1}' `
echo old_uuid: $old_1 
echo new_uuid: $new_1

for fifo_zone_number in 1 2 
do
	echo on $fifo_zone_number

done
mkdir -p /zones/"$new_1"/root/data/snarl/db   /zones/$new_1/root/data/sniffle/db    /zones/$new_1/root/data/howl/db 
cp  -r /zones/"$old_1"/root/var/db/snarl/*     /zones/"$new_1"/root/data/snarl/db
zlogin $new_1 chown -R snarl:snarl /data/snarl
cp  -r /zones/$old_1/root/var/db/sniffle/*   /zones/$new_1/root/data/sniffle/db
zlogin $new_1 chown -R sniffle:sniffle /data/sniffle
cp  -r /zones/$old_1/root/var/db/howl/*      /zones/$new_1/root/data/howl/db
zlogin $new_1 chown -R howl:howl /data/howl

old_1=`vmadm list | grep old_fifo_0_7_home_2 |awk '{print $1}' `
new_1=`vmadm list | grep fifo_2_aio_9_1_home |awk '{print $1}' `

mkdir -p /zones/"$new_1"/root/data/snarl/db   /zones/$new_1/root/data/sniffle/db   /zones/$new_1/root/data/howl/db 
cp  -r /zones/$old_1/root/var/db/snarl/*     /zones/$new_1/root/data/snarl/db
zlogin $new_1 chown -R snarl:snarl /data/snarl
cp  -r /zones/$old_1/root/var/db/sniffle/*   /zones/$new_1/root/data/sniffle/db
zlogin $new_1 chown -R sniffle:sniffle /data/sniffle
cp  -r /zones/$old_1/root/var/db/howl/*      /zones/$new_1/root/data/howl/db
zlogin $new_1 chown -R howl:howl /data/howl


#zfs snapshot zones/opt@fifo-7.0-9.1
zfs list -t    snapshot
