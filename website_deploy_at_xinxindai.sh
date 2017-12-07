#!/bin/bash
set -e
log_file=~/deploy_"$1".log
exec &> >(tee "$log_file")


# v6test
v6test="test_v6_nginx01,test_v6_nginx02,test_v6_tomcat_front01,test_v6_tomcat_admin01,test_v6_tomcat_webservice01,test_v6_tomcat_tradew01,test_v6_tomcat_batch01,test_v6_seo,test_v6_tomcat_front02,test_v6_tomcat_admin02,test_v6_tomcat_webservice02,test_v6_tomcat_tradew02,test_v6_tomcat_batch02"
# stage
v6stage="stage_v6_nginx03,stage_v6_nginx02,stage_v6_nginx01,stage_v6_front02,stage_v6_front03,stage_v6_admin02,stage_v6_admin03,stage_v6_webservice02,stage_v6_webservice03,stage_v6_tradew02,stage_v6_tradew03,stage_v6_batch02,stage_v6_seo002,stage_v6_front01,stage_v6_admin01,stage_v6_webservice01,stage_v6_tradew01,stage_v6_batch01,stage_v6_seo001"
v6teststage="test_v6_nginx01,test_v6_nginx02,test_v6_tomcat_front01,test_v6_tomcat_admin01,test_v6_tomcat_webservice01,test_v6_tomcat_tradew01,test_v6_tomcat_batch01,test_v6_seo,test_v6_tomcat_front02,test_v6_tomcat_admin02,test_v6_tomcat_webservice02,test_v6_tomcat_tradew02,test_v6_tomcat_batch02,stage_v6_nginx03,stage_v6_nginx02,stage_v6_nginx01,stage_v6_front02,stage_v6_front03,stage_v6_admin02,stage_v6_admin03,stage_v6_webservice02,stage_v6_webservice03,stage_v6_tradew02,stage_v6_tradew03,stage_v6_batch02,stage_v6_seo002,stage_v6_front01,stage_v6_admin01,stage_v6_webservice01,stage_v6_tradew01,stage_v6_batch01,stage_v6_seo001"
# temptest
v6temptest="of_nginx_tempnginx01_192.168.31.103,of_nginx_tempnginx02_192.168.31.104,of_tomcat_tempfront01_192.168.31.106,of_tomcat_tempadmin01_192.168.31.109,of_tomcat_tempwebservice01_192.168.31.118,of_tomcat_temptradew01_192.168.31.121,of_tomcat_tempbatch01_192.168.31.124,of_tomcat_tempmobile01_192.168.31.112"
#fix
v6fix="v6_front001.xxdaid.com,v6_admin001.xxdaid.com,v6_batch001.xxdaid.com,v6_trader001.xxdaid.com,v6_webservice001.xxdaid.com"
v6testfix="test_v6_nginx01,test_v6_nginx02,test_v6_tomcat_front01,test_v6_tomcat_admin01,test_v6_tomcat_webservice01,test_v6_tomcat_tradew01,test_v6_tomcat_batch01,test_v6_seo,test_v6_tomcat_front02,test_v6_tomcat_admin02,test_v6_tomcat_webservice02,test_v6_tomcat_tradew02,test_v6_tomcat_batch02,v6_front001.xxdaid.com,v6_admin001.xxdaid.com,v6_batch001.xxdaid.com,v6_trader001.xxdaid.com,v6_webservice001.xxdaid.com"
#performanc test
v6perf="perf_admin01_tomcat,perf_admin02_tomcat,perf_batch_tomcat,perf_front01_tomcat,perf_front02_tomcat,perf_nginx01,perf_seo_tomcat,perf_tradews01_tomcat,perf_tradews02_tomcat,perf_webservice01_tomcat,perf_webservice02_tomcat,perf_webservice03_tomcat"


v6jc="yh-jc-v6-web02-nginx,yh-jc-v6-admin01-tomcat,yh-jc-v6-artener01-tomcat,yh-jc-v6-batch01-tomcat,yh-jc-v6-front01-tomcat,yh-jc-v6-seo01-tomcat,yh-jc-v6-tradew01-tomcat,yh-jc-v6-webservice01-tomcat"


# dashboard
dashboard_key="ct-production-hadoop-cloudera_dashboard.xinxindai.com"
#webapp
webapptest="test_v6_nginx01,test_v6_nginx02,test_v6_webapp_front01"
webappstage="stage_v6_nginx03,stage_v6_nginx02,stage_v6_nginx01,stage_v6_webapp01,stage_v6_webapp02"
webappteststage="test_v6_nginx01,test_v6_nginx02,test_v6_webapp_front01,stage_v6_nginx03,stage_v6_nginx02,stage_v6_nginx01,stage_v6_webapp01,stage_v6_webapp02"
webappperf="test_v6_nginx01,test_v6_nginx02,test_v6_webapp_front01"
#mobile
mobiletest="test_v6_tomcat_mobile01,test_v6_tomcat_mobile02"
mobilestage="stage_v6_mobile01,stage_v6_mobile02"
mobileteststage="test_v6_tomcat_mobile01,test_v6_tomcat_mobile02,stage_v6_mobile01,stage_v6_mobile02"
mobileperf="perf_mobile01_tomcat"
# fk
test_fk_key="test_tomcat_fk001"
stage_fk_key="stage_fk*"
#credit
testcredit="test-v6_credit_app01-tomcat-192.168.38.160.yh"
stagecredit="stage-v6_credit_app01-tomcat-192.168.31.89.yh"
productcredit="v6_credit_app01,v6_credit_app02"
perfcredit="perf_credit01_tomcat"



#others
v6_test_webapp="test_v6_webapp_front01"
v6_test_partener="ct-test-tomcat-partener01.xinxindai.com ct-test-tomcat-partener02.xinxindai.com"
v6_temptest_front="of_tomcat_tempfront01_192.168.31.106"
v6_temptest_admin="of_tomcat_tempadmin01_192.168.31.109"
v6_temptest_webservice="of_tomcat_tempwebservice01_192.168.31.118"
v6_temptest_tradew="of_tomcat_temptradew01_192.168.31.121"
v6_temptest_batch="of_tomcat_tempbatch01_192.168.31.124"
v6_temptest_mobile="of_tomcat_tempmobile01_192.168.31.112"
v6_temptest_webapp="of_tomcat_tempwebapp01_192.168.31.115"
v6_stage_mobile="stage_v6_mobile01 stage_v6_mobile02"
v6_stage_webapp="stage_v6_webapp01 stage_v6_webapp02"
v6_stage_partener="ct-stage-tomcat-partener01.xinxindai.com ct-stage-tomcat-partener02.xinxindai.com"

#production
mobileproduction="v6_mobile01,v6_mobile02"
creditproduction="v6_credit_app01,v6_credit_app02"
webappproduction="v6_webapp01,v6_webapp02,v6_webapp03"
v6production="v6_nginx01,v6_nginx02,v6_nginx03,v6_admin01,v6_admin02,v6_batch01,v6_batch02,v6_front01,v6_front02,v6_front03,v6_tradew01,v6_tradew02,v6_tradew03,v6_webservice01,v6_webservice02,v6_webservice03"



eval minion_id='$'$1
echo target minions :  $minion_id

if [ "$minion_id" == "$" ] ;then echo target minion is empty,please input target group; exit 1; fi

if [[ -z "$2" ]]  ;then 
  echo skip compile war file
else  
  cd /home/wujunrong/tmp
  echo $2
  echo enter directory:
  svn_checkout_directory=`echo "$2" |rev|cut -d "/"  -f 1 |rev`
  echo     $svn_checkout_directory
  mkdir -p $svn_checkout_directory
  echo svn co "$2"  "$3"  "$svn_checkout_directory"
  eval svn co "$2"  "$3"  "$svn_checkout_directory"
  cd       $svn_checkout_directory
  echo ==== rsync static files ==
  if  echo $1 | grep  -C 3 -v webapp  |grep  -C 3 -v mobile  |grep  -C 3 -v credit ;then  rsync -avhi  ./v6_front/trunk/src/main/webapp/static/      /opt/ci/rsync/v6_static_rsync/      --cvs-exclude  --checksum ;fi
  if  echo $1 | grep  -C 3    webapp                                               ;then  rsync -avhi  ./v6_webapp/trunk/src/main/webapp/static/     /opt/ci/rsync/webapp_static_rsync/  --cvs-exclude  --checksum ;fi
  echo ==== start compile      ==
  >/home/wujunrong/mvn_error.txt;rm -rf /usr/local/maven/mvn_repo/com/xxdai/*;find  ./    -name pom.xml   | grep -v "v6_batch/trunk/pom.xml" | grep -v v6_batch/trunk/batch-core/pom.xml  |grep -v  -E '\./pom.xml'|  xargs -I {}  sh  -c 'path_dir=`dirname {}`&& cd $path_dir && { /usr/local/maven/bin/mvn clean package ; echo $? >./return_val.txt ; }  | tee ./output.txt  ;return_val=`cat ./return_val.txt` ;  if [ "$return_val" -ne 0 ];then ( cat ./output.txt  >>/home/wujunrong/mvn_error.txt)  ;else  cp  ./target/*.war   /home/wujunrong/  ;fi' ; if [ -s /home/wujunrong/mvn_error.txt ] ;then { echo -e "From: wujunrong@xinxindai.com\nSubject: mvn build error info \n\nThe following is error message after building.";cat /home/wujunrong/mvn_error.txt; } | ssmtp -d wujunrong@xinxindai.com,sunjiao@xinxindai.com;exit 77 ; fi
  
  if  echo $1 | grep  -C 3 -v webapp |grep  -C 3 -v mobile  |grep  -C 3 -v credit ;then echo "create v6 static package";     cd ./v6_front/trunk/src/main/webapp/static     && zip -q -9  -r  "--exclude=*.svn*"  static.zip   *          && mv -f static.zip         /opt/ci/packages/  ;fi
  if  echo $1 | grep  -C 3    webapp                                              ;then echo "create webapp static package"; cd ./v6_webapp/trunk/src/main/webapp/static/   && zip -q -9  -r  "--exclude=*.svn*"  webapp_static.zip   *   && mv -f webapp_static.zip  /opt/ci/packages/  ;fi
  
 
  mv -f /home/wujunrong/*.war    /opt/ci/packages/
fi


minion_id_aux=$( tmp=`echo $minion_id | sed 's/,/ or /g'`;echo \( $tmp \) )

if salt -L "$minion_id" match.compound 'G@server_type:tomcat' | grep  -C 100  True     ; then
   echo -e "\nDownloading war files"
      salt  -C "$minion_id_aux  and G@server_type:tomcat"    cp.get_file     template=jinja  salt://ci/files/packages/{{grains.package_name}}     /root/{{grains.package_name}}
   echo -e "\nDownloading war files finished"
   echo -e "\n ----- uzip war files-------"
      salt  -C "$minion_id_aux and G@server_type:tomcat"     cmd.shell       template=jinja  "rm -fr /root/xxd_tomcat/* && mkdir -p /root/xxd_tomcat && unzip  -q -o  /root/{{grains.package_name}}      -d /root/xxd_tomcat/"
   echo ----- unzip war file finished -----    
  
   echo ---- stop tomcat -----
      salt  -C "$minion_id_aux and G@server_type:tomcat"     cmd.shell      "/etc/init.d/tomcat stop"  	 
   echo ----  stop all tomcat server finised  -----
fi


echo =====start umount directory===== 

if salt -L "$minion_id" match.compound 'P@image_dir:(/opt|/usr)       '  | grep  -C 100 True  ; then   salt  -C "P@image_dir:(/opt|/usr)         and $minion_id_aux "     cmd.shell      template=jinja   "salt-call   --local  --retcode-passthrough  state.single    mount.unmounted  name='{{grains.image_dir}}' device='{{grains.storage_ip}}:{{grains.storage_image_dir}}' "               ; echo -e "umount image_dir finished\n "       ;fi
if salt -L "$minion_id" match.compound 'P@admin_image_dir:(/opt|/usr) '  | grep  -C 100 True  ; then   salt  -C "P@admin_image_dir:(/opt|/usr)   and $minion_id_aux "     cmd.shell      template=jinja   "salt-call   --local  --retcode-passthrough  state.single    mount.unmounted  name='{{grains.admin_image_dir}}' device='{{grains.storage_ip}}:{{grains.storage_admin_image_dir}}'  "  ; echo -e "umount admin_image_dir finished\n"  ;fi     
if salt -L "$minion_id" match.compound 'P@admin_images_dir:(/opt) '      | grep  -C 100 True  ; then   salt  -C "P@admin_images_dir:(/opt)       and $minion_id_aux "     cmd.shell      template=jinja   "salt-call   --local  --retcode-passthrough  state.single    mount.unmounted  name='{{grains.admin_images_dir}}' device='{{grains.storage_ip}}:{{grains.storage_admin_images_dir}}' " ; echo -e "umount admin images_dir finished\n" ;fi     
if salt -L "$minion_id" match.compound 'P@download_dir:(/usr)'           | grep  -C 100 True  ; then   salt  -C "P@download_dir:(/usr)           and $minion_id_aux "     cmd.shell      template=jinja   "salt-call   --local  --retcode-passthrough  state.single    mount.unmounted  name='{{grains.download_dir}}' device='{{grains.storage_ip}}:{{grains.storage_download_dir}}'"          ; echo -e "umount download_dir finished\n"     ;fi

echo =====umount all directory finished=====
echo ----- start unzip war file and download config file --------
if  salt -L "$minion_id" match.compound 'G@server_type:tomcat' | grep -C 100 True ; then
    echo ----- Deleting  directory---------
    salt  -C "$minion_id_aux and G@server_type:tomcat"     cmd.shell       template=jinja  "if !  mount | grep opt/webserver  ; then rm -rf  {{grains.tomcat_app_dir}}/* ;else exit 10  ;fi "
    salt  -C "$minion_id_aux and G@server_type:tomcat"     cmd.shell       template=jinja  "rm -rf /opt/webserver/v6_tomcat/work/Catalina"
    echo -e "\n ----- move war contents-------"
    salt  -C "$minion_id_aux and G@server_type:tomcat"     cmd.run         template=jinja   "mv -f /root/xxd_tomcat/*   {{grains.tomcat_app_dir}}/ "
    echo ----- unzip war file finished -----    
    echo -e "\n ------Downloading config files --------"
    salt  -C "$minion_id_aux and G@server_type:tomcat"     cp.get_dir      template=jinja  salt://{{grains.conf_dir}}/                 {{grains.tomcat_app_dir}}/WEB-INF
    echo -e "\n ------deploy config    files --------"
    salt  -C "$minion_id_aux and G@server_type:tomcat"     cmd.run         template=jinja  "mv -f {{grains.tomcat_app_dir}}/WEB-INF/\`basename {{grains.conf_dir}}\`/*                      {{grains.tomcat_app_dir}}/WEB-INF/classes/"
    salt  -C "$minion_id_aux and G@server_type:tomcat"     cmd.shell       template=jinja  "chown -R tomcat:tomcat {{grains.tomcat_app_dir}} "
    echo ----- download config file finished -----
fi

echo ======start rsync static resource===============
if   echo  $minion_id  | grep  webapp ; then
     echo  --deploy webapp static resource-- 
	 salt   -C "P@server_type:nginx and $minion_id_aux"   cp.get_file   template=jinja  salt://ci/files/packages/webapp_static.zip    /root/webapp_static.zip
     salt   -C "P@server_type:nginx and $minion_id_aux"   cmd.run       template=jinja   "if !  mount | grep /usr/local  ; then rm -rf  {{grains.webapp_static_rsync_dest_dir}}/* && unzip  -q -o  /root/webapp_static.zip  -d   {{grains.webapp_static_rsync_dest_dir}}  ;else exit 10 ;fi" ;
fi
if   echo  $minion_id  |grep -E '.*ngin.*v6.*front.*|.*ngin.*admin|.*ngin.*webservice|.*ngin.*tradew|.*ngin.*batch|.*ngin.*seo|.*ngin.*credit_app|.*ngin.*partener'| grep -v webapp ; then
     echo  --deploy v6     static resource-- 
	 salt   -C "P@server_type:nginx and $minion_id_aux"   cp.get_file   template=jinja  salt://ci/files/packages/static.zip    /root/static.zip
	 salt   -C "P@server_type:nginx and $minion_id_aux"   cmd.run       template=jinja   "if !  mount | grep /usr/local  ; then  cd {{grains.v6_static_rsync_dest_dir}} && ls | grep -v ^m$ |xargs rm -fr  && unzip  -q -o  /root/static.zip     -d   {{grains.v6_static_rsync_dest_dir}}      ;else exit 10 ;fi" ;            
fi

echo ====== rsync static resource finished===============
echo ------ start mount directories ------------

if salt -L "$minion_id" match.compound 'P@image_dir:(/opt|/usr)       '     | grep -C 100 True  ; then
   
   salt  -C "P@image_dir:(/opt|/usr)         and $minion_id_aux "      cmd.shell       template=jinja  "salt-call   --local   --retcode-passthrough  state.single    mount.mounted  name='{{grains.image_dir}}' device='{{grains.storage_ip}}:{{grains.storage_image_dir}}'   fstype='nfs'  'mkmnt=True' opts='vers=3' " 
   echo -e "mounting image_dir  finished\n"
fi 

if salt -L "$minion_id" match.compound 'P@admin_image_dir:(/opt|/usr) '     | grep -C 100 True  ; then   
   salt  -C "P@admin_image_dir:(/opt|/usr)   and $minion_id_aux "      cmd.shell       template=jinja  "salt-call   --local   --retcode-passthrough  state.single    mount.mounted  name='{{grains.admin_image_dir}} ' device='{{grains.storage_ip}}:{{grains.storage_admin_image_dir}}'   fstype='nfs'  'mkmnt=True' opts='vers=3' " 
   echo -e "mounting image_dir  finished\n"
fi

if salt -L "$minion_id" match.compound 'P@admin_images_dir:(/opt) '         | grep -C 100 True  ; then
   salt  -C "P@admin_images_dir:(/opt)   and $minion_id_aux "          cmd.shell       template=jinja  "salt-call   --local    --retcode-passthrough state.single    mount.mounted  name='{{grains.admin_images_dir}}' device='{{grains.storage_ip}}:{{grains.storage_admin_images_dir}}'   fstype='nfs'  'mkmnt=True' opts='vers=3' " 
   echo -e "mounting image_dir  finished\n"
fi
   
if salt -L "$minion_id" match.compound 'P@download_dir:(/usr)'              | grep -C 100 True  ; then
   salt  -C "P@download_dir:(/usr)           and $minion_id_aux "      cmd.shell       template=jinja  "salt-call   --local    --retcode-passthrough state.single    mount.mounted  name='{{grains.download_dir}}' device='{{grains.storage_ip}}:{{grains.storage_download_dir}}'   fstype='nfs'  'mkmnt=True' opts='vers=3' " 
   echo -e "mounting image_dir  finished\n"
fi

echo ------ mount directories finished ------------
echo ====== start tomcat server ===============
if salt -L "$minion_id" match.compound 'G@server_type:tomcat'  | grep -C 100 True ; then  salt   -C "$minion_id_aux and G@server_type:tomcat"      cmd.shell     "/etc/init.d/tomcat start" ;echo starting tomcat server finished ;fi
echo ====== tomcat start finished ===============




# sed -n '1, /minion_.*_aux=/ p'    ./deploy.sh > ./compile.sh && chmod +x  ./compile.sh
# sed -n '/stop tomcat/, /stop all tomcat server finised/ p'   ./deploy.sh  > ./stop_tomcat.sh &&  chmod +x stop_tomcat.sh
# sed -n '/Downloading config files/, /download config file finished/ p'    /cygdrive/c/SVN/code/deploy.sh
# sed -n '/= start tomcat server/, /tomcat start finished/ p'    /cygdrive/c/SVN/code/deploy.sh




#  rsync -avhi  ./v6_front/trunk/src/main/webapp/static/  /opt/ci/rsync/v6_static_rsync/     --cvs-exclude
#  rsync -avhi  ./v6_front/trunk/src/main/webapp/static/    /opt/ci/rsync/v6_static_rsync/  --dry-run  --cvs-exclude
#  >/home/wujunrong/mvn_error.txt;find  ./    -name pom.xml   | grep -v "v6_batch/trunk/pom.xml" | grep -v ./v6_batch/trunk/batch-core/pom.xml |  xargs -I {}  sh -c 'path_dir=`dirname {}`&& cd $path_dir && { mvn clean package ; echo $? >./return_val.txt ; }  | tee ./output.txt  ;return_val=`cat ./return_val.txt` ;  if [ "$return_val" -ne 0 ];then ( cat ./output.txt  >>/home/wujunrong/mvn_error.txt)  ;else  cp  ./target/*.war   /home/wujunrong/  ;fi' ; if [ -s /root/mvn_error.txt ] ;then { echo -e "From: wujunrong@xinxindai.com\nSubject: mvn build error info \n\nThe following is error message after building.";cat /home/wujunrong/mvn_error.txt; } | ssmtp -d wujunrong@xinxindai.com ; fi
#  cd ./v6_front/trunk/src/main/webapp/static  && zip -q -9  -r  "--exclude=*.svn*"  static.zip   *   && mv -f static.zip /home/wujunrong/

#mv -f /home/wujunrong/*.war /home/wujunrong/static.zip   /home/wujunrong/webapp_static.zip  /opt/ci/packages/

#grains file:
#tomcat_app_dir: /opt/webserver/v6_tomcat/webapps/xxdai_tradews
#package__name: v6_tradews.war
#grains.conf_dir: stage_v6_tradews

# static RSYNC CONF
#Rsync_dir=/opt/ci/rsync
#rsync_server=192.168.38.10
#rsync_user=rsync_ci
#rsync_passwd_file=/etc/rsync.pass
#v6_static_exclue_args="--exclude image --exclude download --exclude admin/image --exclude m"

#umount -l /opt/webserver/v6_tomcat/webapps/ROOT/static/image
#umount -l /opt/webserver/v6_tomcat/webapps/ROOT/static/admin/image
#umount -l /usr/local/nginx/html/static/download
#salt  "$minion"    cmd.run         template=jinja   "rsync -vzrtopg --delete --progress rsync_ci@$192.168.38.10::webapp_static_rsync      /usr/local/nginx/html/static/m --password-file=/etc/rsync.pass"



# v6静态文件在rsync的源和目标目录
#v6_static_rsync_source_dir="v6_static_rsync"
#v6_static_rsync_dest_dir="/usr/local/nginx/html/static"
# webapp静态文件再rsync的源和目标目录
#webapp_static_rsync_source_dir="webapp_static_rsync"
#webapp_static_rsync_dest_dir="/usr/local/nginx/html/static/m"

#salt   -C "P@server_type:nginx and $minion_id_aux"   cmd.run   template=jinja   "if !  mount | grep /usr/local  ; then rsync -vzrtopg --delete --progress rsync_ci@192.168.38.10::{{grains.webapp_static_rsync_source_dir}}  {{grains.webapp_static_rsync_dest_dir}}  --password-file=/etc/rsync.pass ;else exit 10 ;fi" ;
#salt   -C "P@server_type:nginx and $minion_id_aux"   cmd.run   template=jinja   "if !  mount | grep /usr/local  ; then rsync -vzrtopg --delete --progress rsync_ci@192.168.38.10::{{grains.v6_static_rsync_source_dir}}      {{grains.v6_static_rsync_dest_dir}}      --password-file=/etc/rsync.pass --exclude image --exclude download --exclude admin/image --exclude m ;else exit 10 ;fi" ;

#if salt -L "$minion_id" match.compound 'P@image_dir:(/opt|/usr)       '  | grep  -C 100 True  ; then   salt  -C "P@image_dir:(/opt|/usr)         and $minion_id_aux "     cmd.shell      template=jinja   "umount -l {{grains.image_dir}} "        && echo -e "umount image_dir finished\n "       ;fi
#if salt -L "$minion_id" match.compound 'P@admin_image_dir:(/opt|/usr) '  | grep  -C 100 True  ; then   salt  -C "P@admin_image_dir:(/opt|/usr)   and $minion_id_aux "     cmd.shell      template=jinja   "umount -l {{grains.admin_image_dir}}  " && echo -e "umount admin_image_dir finished\n"  ;fi     
#if salt -L "$minion_id" match.compound 'P@admin_images_dir:(/opt) '      | grep  -C 100 True  ; then   salt  -C "P@admin_images_dir:(/opt)       and $minion_id_aux "     cmd.shell      template=jinja   "umount -l {{grains.admin_images_dir}} " && echo -e "umount admin images_dir finished\n" ;fi     
#if salt -L "$minion_id" match.compound 'P@download_dir:(/usr)'           | grep  -C 100 True  ; then   salt  -C "P@download_dir:(/usr)           and $minion_id_aux "     cmd.shell      template=jinja   "umount -l {{grains.download_dir}}     " && echo -e "umount download_dir finished\n"     ;fi

#salt -C "P@image_dir:(/opt|/usr)         and $minion_id_aux "      cmd.shell       template=jinja   "mkdir -p  {{grains.image_dir}}             && mount -t nfs -o vers=3 {{grains.storage_ip}}:{{grains.storage_image_dir}}          {{grains.image_dir}}       "    && echo -e "mounting image_dir  finished\n"        
#salt -C "P@admin_image_dir:(/opt|/usr)   and $minion_id_aux "      cmd.shell       template=jinja   "mkdir -p  {{grains.admin_image_dir}}       && mount -t nfs -o vers=3 {{grains.storage_ip}}:{{grains.storage_admin_image_dir}}    {{grains.admin_image_dir}} "    && echo -e "mounting admin_image_dir finished\n"   
#salt -C "P@admin_images_dir:(/opt)   and $minion_id_aux "          cmd.shell      template=jinja   "mkdir -p  {{grains.admin_images_dir}}       && mount -t nfs -o vers=3 {{grains.storage_ip}}:{{grains.storage_admin_images_dir}}  {{grains.admin_images_dir}} "   && echo -e "mounting admin_images_dir finished\n"  
#salt -C "P@download_dir:(/usr)           and $minion_id_aux "      cmd.shell       template=jinja   "mkdir -p  {grains.storage_download_dir}}   && mount -t nfs -o vers=3 {{grains.storage_ip}}:{{grains.storage_download_dir}}       {{grains.download_dir}}    "    && echo -e "mounting download_dir  finished\n"     

#minion_id="of_nginx_tempnginx02_192.168.31.104 of_tomcat_tempfront01_192.168.31.106 of_tomcat_tempwebservice01_192.168.31.118 of_tomcat_tempadmin01_192.168.31.109 of_tomcat_temptradew01_192.168.31.121 of_tomcat_tempbatch01_192.168.31.124"
#minion_id="test_v6_nginx01,test_v6_nginx02,test_v6_tomcat_front01,test_v6_tomcat_admin01,test_v6_tomcat_webservice01,test_v6_tomcat_tradew01,test_v6_tomcat_batch01,test_v6_seo,test_v6_tomcat_front02,test_v6_tomcat_admin02,test_v6_tomcat_webservice02,test_v6_tomcat_tradew02,test_v6_tomcat_batch02"

# salt master.d 中的nodegroup,用户批量开启和关闭环境
# test_group=test_v6tomcat
# stage_group=stage_v6tomcat
# temptest_group=temptest_v6tomcat
