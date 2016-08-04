#!/bin/ksh
#version:21030621
tr -d "\015"  </etc/opt/jp1base/JP1_Monitor_For_AIX.ini > /etc/opt/jp1base/JP1_Sys_Monitor_Cfg.ini

. /etc/opt/jp1base/JP1_Sys_Monitor_Cfg.ini 


# the following is *.stop file monitor,if file exists,then send alarm
    #file_name=/*.stop
    #IFS=$(echo -en "\n\b")
    for directory_name in "${JP1_File_Creation_Monitor[@]}"        
        do 
          #echo $directory_name_win
          #directory_name=$(cygpath -u ${directory_name_win})
          echo "array member - $directory_name"
          #if [ -d $directory_name ];  then
          #     echo $directory_name found
          #else 
          #     echo $directory_name not found
          #     /opt/jp1base/bin/jevsend -i 997 -d "${IM_server_IP}" -m  "JP1-AIX-Sys-Monitor Error,The directory configured does not exist! Directory name is: ${directory_name}"  -e "SEVERITY=Warning" -e "OBJECT_NAME=JP1-AIX-Sys-Monitor"
          #fi
                    
          full_file_name=$(echo ${directory_name})
              echo $full_file_name
          files_number=$(ls ${full_file_name}   2> /dev/null | wc -l) 
              echo file number: $files_number
          files=$(ls ${full_file_name}  2> /dev/null ) 
          #windows_file_names=$(cygpath -w ${files})
          
          
          if [[ $files_number -gt 0 ]]
          then
              echo "Cache files exist: do something with them"
              /opt/jp1base/bin/jevsend -i 983 -d "${IM_server_IP}" -m  "STOP file is created, File name: [${files}] "  -e "SEVERITY=Warning" -e "OBJECT_NAME=JP1-AIX-Sys-Monitor"
          else
             echo "No cache files..."
          fi

    done


#the following is cpu monitor
#sar 29 10 | grep Average | awk -v cpu_threshold=$cpu_monitor_threshold -v ip_adress=$IM_server_IP '{ if($2 +$3 +$4 >=cpu_threshold)  print "/opt/jp1base/bin/jevsend -i 992 -d \"" ip_adress "\" -m  \"CPU average usage rate " $2 +$3 +$4 "% exceeds threshold\"  -e \"SEVERITY=Error\" -e \"OBJECT_NAME=JP1-AIX-Sys-Monitor\"" |"/bin/ksh" ;close("/bin/ksh")}' &

#the following is physical busy rate monitor
#( physical_disk_io_busy_rate=$(sar -d 30 10 |sed  -n  '/Average/,$ p' |sed  '1 s/Average//') &&\
#  echo "$physical_disk_io_busy_rate"|awk -v disk_th=$disk_io_usage_rate_threshold -v disk_cri_th=$disk_io_usage_rate_critical_threshold -v ip_adress=$IM_server_IP '{ if( $2 >=disk_th && $2<disk_cri_th)  print "/opt/jp1base/bin/jevsend -i 992 -d \"" ip_adress "\" -m  \"Disk IO average usage rate "$2"% exceeds threshold on physical disk--"$1" \"  -e \"SEVERITY=Warning\" -e \"OBJECT_NAME=JP1-Sys-Monitor\"" |"/bin/ksh" ;close("/bin/ksh")}' &&\
#  echo "$physical_disk_io_busy_rate"|awk -v disk_cri_th=$disk_io_usage_rate_critical_threshold -v ip_adress=$IM_server_IP '{ if($2 >= disk_cri_th)   print "/opt/jp1base/bin/jevsend -i 986 -d \"" ip_adress "\" -m  \"Disk IO average usage rate " $2 "% exceeds critical threshold on physical disk--"$1" \"  -e \"SEVERITY=Error\" -e \"OBJECT_NAME=JP1-Sys-Monitor\"" |"/bin/ksh" ;close("/bin/ksh")}' )&


#Process monitor
#1 the following is aix process name monitor, if process name is found in ps -ef command output,then consider this process exsits.
    all_process_status=$(ps -ef)
    #echo "$all_process_status"
    for i in ${AIX_processes_name_monitor[@]}        
          do 
          #echo "array member - $i"
          #process name is in the ninth column or the eighth column because May 01 occupy two column while 0:00 occupy one column
          died_pocess=$(echo "$all_process_status"|awk -v pattern=$i 'BEGIN{n=0} $8~pattern||$9~pattern {++n } END {if (n==0) print"Monitored Process does not exist: " pattern }')
          if [ -n "$died_pocess" ];then
            #echo $died_pocess
            /opt/jp1base/bin/jevsend -i 994 -d "${IM_server_IP}" -m  "${died_pocess}"  -e "SEVERITY=Error" -e "OBJECT_NAME=JP1-AIX-Sys-Monitor"
          fi
    done
#2 process name and parameter monitor
   #echo "cde"
   #the parameter in the following command is wrapped in quotes, This tells the shell to ignore spaces in the arguments; 
   process_index=0
   for j in "${AIX_processes_name_and_para_monitor[@]}"        
         do 
                  
         #echo "array member - $j"
         #function1: check if the process name containing its parameter is in the ps -ef command output line
         typeset -i process_number=$(echo "$all_process_status" | grep -i "${j}"|wc -l)
         #echo line matched: $process_number
         #if ${process_monitor_event_level[$process_index]} does not exist,I think these configuration item does not exist: linux_processes_name_and_para_monitor[process_index] process_monitor_event_level[process_index] processes_number_not_equal_to[process_index]
         while [[ -z "${process_monitor_event_level[$process_index]}" ]] ; do
                let process_index=process_index+1
         done
         
         if [ $process_number -eq 0 ]; then
            /opt/jp1base/bin/jevsend -i 987 -d "${IM_server_IP}" -m  "Monitored Process does not exist: ${j}"  -e "SEVERITY=${process_monitor_event_level[$process_index]}" -e "OBJECT_NAME=JP1-AIX-Sys-Monitor"
         fi
         
         #function2: check whether this pocess's nmuber match condition
         if [[ -n "${processes_number_not_equal_to[$process_index]}" && "${processes_number_not_equal_to[$process_index]}" -ne "$process_number" && "$process_number" -ne 0 ]];then
            echo  process number eq criterion is monitored, process index: $process_index, value:${processes_number_not_equal_to[$process_index]} -- the number of running process :$process_number
            /opt/jp1base/bin/jevsend -i 986 -d "${IM_server_IP}" -m  "The total number of monitored process [${j}] is not equal to designated value.The total number of the running processes is:${process_number}"  -e "SEVERITY=${process_monitor_event_level[$process_index]}" -e "OBJECT_NAME=JP1-AIX-Sys-Monitor"
         fi
         
              # three criterion:the check whether the value is set, check whether criterion is fulfilled ,chech whether process exist.
         if [[ -n "${processes_number_greater_or_equal[$process_index]}" && "${processes_number_greater_or_equal[$process_index]}" -le "$process_number" && "$process_number" -ne 0 ]];then
            echo process number gt criterion is monitored, process index: $process_index, value:${processes_number_greater_or_equal[$process_index]} -- the number of running process :$process_number
            /opt/jp1base/bin/jevsend -i 985 -d "${IM_server_IP}" -m  "The total number of monitored process is greater or equal to threshold. Process name is: [${j}]. The total number of the running processes is:${process_number} "  -e "SEVERITY=${process_monitor_event_level[$process_index]}" -e "OBJECT_NAME=JP1-AIX-Sys-Monitor"
         fi         
         
         if [[ -n "${processes_number_less_or_equal[$process_index]}" && "${processes_number_less_or_equal[$process_index]}" -ge "$process_number" && "$process_number" -ne 0  ]];then
            echo process number lt criterion is monitored, process index: $process_index, value:${processes_number_less_or_equal[$process_index]} -- the number of running process :$process_number
            /opt/jp1base/bin/jevsend -i 984 -d "${IM_server_IP}" -m  "The total number of monitored process is less or equal to threshold. Process name is: [${j}]. The total number of the running processes is: ${process_number}"  -e "SEVERITY=${process_monitor_event_level[$process_index]}" -e "OBJECT_NAME=JP1-AIX-Sys-Monitor"
         fi         
         
         let process_index=process_index+1
         #echo "abcd"
   done
#the following is memory usage rate monitor
# use lsps command| print second line (2 before p mean match the secnod time) | print the fifth column

lsps -a | sed -n '2,$ p'| awk -v ps_cri_ch=$page_space_usage_critical_threshold '{if($5>ps_cri_ch) print "Swap space usage rate " $5 "% exceeds critical threshold on "$1" "$2" " $3 }'>/etc/opt/jp1base/JP1_monitor_result7.txt
lsps -a | sed -n '2,$ p'| awk -v ps_cri_ch=$page_space_usage_critical_threshold  -v ps_ch=$page_space_usage_threshold '{if($5<ps_cri_ch && $5>=ps_ch) print "Swap space usage rate " $5 "% exceeds threshold on "$1" "$2" " $3 }'>/etc/opt/jp1base/JP1_monitor_result8.txt

    #page_space_usage_rate=6
		#if  [[ "$page_space_usage_rate" -ge "$page_space_usage_threshold" && "$page_space_usage_rate" -lt "$page_space_usage_critical_threshold" ]];then
		#			  /opt/jp1base/bin/jevsend -i 993 -d "${IM_server_IP}" -m  "Virtual memory usage rate ${page_space_usage_rate}% exceeds threshold"  -e "SEVERITY=Warning" -e "OBJECT_NAME=JP1-AIX-Sys-Monitor"

    
#the following is inode usage rate monitor  --remove %|print from second line to the last line and remove % character on the second match(2p:2 means second match , p means print matched line )
df -i | grep % |sed -n '2,$ s/%//2p'|awk -v threshold=$inode_usage_rate_threshold -v critical_threshold=$inode_usage_rate_critical_threshold  '{if ($6>=threshold && $6<critical_threshold) printf "Inode usage rate %s%% exceeds threshold on file system %s \n", $6,$7}'>/etc/opt/jp1base/JP1_monitor_result3.txt
df -i | grep % |sed -n '2,$ s/%//2p'|awk -v threshold=$inode_usage_rate_critical_threshold  '{if ($6>=threshold) printf "Inode usage rate %s%% exceeds critical threshold  on file system %s \n", $6,$7}'>/etc/opt/jp1base/JP1_monitor_result5.txt


#the following is diskspace usage rate monitor  --remove %|print from second line to the last line and remove % character on the first match
df -i | grep % |sed -n '2,$ s/%//p'|awk  -v disk_th=$disk_usage_rate_threshold -v disk_critical_th=$disk_usage_rate_critical_threshold '{if ($4>=disk_th && $4<disk_critical_th)  printf "Diskspace usage rate %s%% exceeds threshold on file system %s \n",  $4,$7}'>/etc/opt/jp1base/JP1_monitor_result4.txt
df -i | grep % |sed -n '2,$ s/%//p'|awk  -v disk_th=$disk_usage_rate_critical_threshold '{if ($4>=disk_th) printf "Diskspace usage rate %s%% exceeds critical threshold on file system %s \n",  $4,$7}'>/etc/opt/jp1base/JP1_monitor_result6.txt


#the following is AIX system log monitor
if [ -f /etc/opt/jp1base/aix_sys_log_monitor_timestamp.txt ] 
then
     
     startdate=$(cat /etc/opt/jp1base/aix_sys_log_monitor_timestamp.txt)
     LEN=$(echo ${#startdate})
     if [ $LEN -eq 10 ]; then
        #aix_sys_log_monitor_timestamp.txt is ok
        #echo "$startdate  have 10 characters"
        errpt -s  "$startdate" |awk '($3~/P/)&&($4~/H/){print $0;}'>/etc/opt/jp1base/JP1_monitor_result1.txt
        errpt -s  "$startdate" |awk '($3~/U/)&&($4~/H/){print $0;}'>/etc/opt/jp1base/JP1_monitor_result2.txt
        
        #------------this section is test code-------------
        #errpt |awk '($3~/P/)&&($4~/S/){print $0;}'>/etc/opt/jp1base/JP1_monitor_result1.txt
        #errpt -s 0409095013 |awk  '($3~/P/)&&($4~/S/){print $0;}'>/etc/opt/jp1base/JP1_monitor_result2.txt
        #------------------------------------------------------
     
     else
        echo "$startdate has doesnot have 10 characters"
        # aix_sys_log_monitor_timestamp.txt is not ok ,send shell error debug alarm,this file store start time parameter for errpt command
        /opt/jp1base/bin/jevsend -i 997 -d "${IM_server_IP}" -m  "JP1-AIX-Sys-Monitor Error,Please check JP1_Sys_Log_Monitor.sh!"  -e "SEVERITY=Debug" -e "OBJECT_NAME=JP1-AIX-Sys-Monitor"
     fi
    
     
else
     date +"%m%d%H%M%y">/etc/opt/jp1base/aix_sys_log_monitor_timestamp.txt
     #errpt|awk '($3~/P/)&&($4~/H/){print $0;}'>/etc/opt/jp1base/JP1_monitor_result1.txt
     #errpt|awk '($3~/U/)&&($4~/H/){print $0;}'>/etc/opt/jp1base/JP1_monitor_result2.txt
     #When the shell is run for the first time,aix_sys_log_monitor_timestamp.txt does not exist,so creat file here.
     print "File /etc/opt/jp1base/aix_sys_log_monitor_timestamp.txt does not exist or is no regular file">>/etc/opt/jp1base/JP1_log_monitor_error.log

     /opt/jp1base/bin/jevsend -i 998 -d "${IM_server_IP}" -m  "JP1-AIX-Sys-Monitor First Time Start OR Monitor file lost."  -e "SEVERITY=Debug" -e "OBJECT_NAME=JP1-AIX-Sys-Monitor"
fi


#  update date
date +"%m%d%H%M%y">/etc/opt/jp1base/aix_sys_log_monitor_timestamp.txt


#  send different type of alarm stored in JP1_monitor_result*.txt file  respectively.
while read line           
do           
    echo "$line"           
   /opt/jp1base/bin/jevsend -i 999 -d "${IM_server_IP}" -m  "$line"  -e "SEVERITY=Error" -e "OBJECT_NAME=JP1-AIX-Sys-Monitor"
done </etc/opt/jp1base/JP1_monitor_result1.txt

while read line2           
do           
    echo "$line2"           
   /opt/jp1base/bin/jevsend -i 998 -d "${IM_server_IP}" -m  "$line2"  -e "SEVERITY=Warning" -e "OBJECT_NAME=JP1-AIX-Sys-Monitor"
done </etc/opt/jp1base/JP1_monitor_result2.txt

while read line3           
do           
    echo "$line3"           
   /opt/jp1base/bin/jevsend -i 996 -d "${IM_server_IP}" -m  "$line3"  -e "SEVERITY=Warning" -e "OBJECT_NAME=JP1-AIX-Sys-Monitor"
done </etc/opt/jp1base/JP1_monitor_result3.txt

while read line4           
do           
    echo "$line4"           
   /opt/jp1base/bin/jevsend -i 995 -d "${IM_server_IP}" -m  "$line4"  -e "SEVERITY=Warning" -e "OBJECT_NAME=JP1-AIX-Sys-Monitor"
done </etc/opt/jp1base/JP1_monitor_result4.txt

while read line5           
do           
    echo "$line5"           
   /opt/jp1base/bin/jevsend -i 989 -d "${IM_server_IP}" -m  "$line5"  -e "SEVERITY=Error" -e "OBJECT_NAME=JP1-AIX-Sys-Monitor"
done </etc/opt/jp1base/JP1_monitor_result5.txt

while read line6           
do           
    echo "$line6"           
   /opt/jp1base/bin/jevsend -i 988 -d "${IM_server_IP}" -m  "$line6"  -e "SEVERITY=Error" -e "OBJECT_NAME=JP1-AIX-Sys-Monitor"
done </etc/opt/jp1base/JP1_monitor_result6.txt
while read line7           
do           
    echo "$line7"           
   /opt/jp1base/bin/jevsend -i 991 -d "${IM_server_IP}" -m  "$line7"  -e "SEVERITY=Error" -e "OBJECT_NAME=JP1-AIX-Sys-Monitor"
done </etc/opt/jp1base/JP1_monitor_result7.txt
while read line8           
do           
    echo "$line8"           
   /opt/jp1base/bin/jevsend -i 993 -d "${IM_server_IP}" -m  "$line8"  -e "SEVERITY=Warning" -e "OBJECT_NAME=JP1-AIX-Sys-Monitor"
done </etc/opt/jp1base/JP1_monitor_result8.txt