#!/bin/ksh
#version 20130515
tr -d "\015" </etc/opt/jp1base/JP1_Monitor_For_Linux.ini>/etc/opt/jp1base/JP1_Sys_Monitor_Cfg.ini 

. /etc/opt/jp1base/JP1_Sys_Monitor_Cfg.ini 

#the following is cpu monitor
#( cpu_usage_info=$(sar 30 10 | grep Average) ;\
#echo "$cpu_usage_info"|awk -v cpu_threshold=$cpu_monitor_threshold -v cpu_cri_th=$cpu_monitor_critical_threshold -v ip_adress=$IM_server_IP '{ if( 100-$8 >=cpu_threshold && 100-$8<cpu_cri_th)  print "/opt/jp1base/bin/jevsend -i 992 -d \"" ip_adress "\" -m  \"CPU average usage rate " 100-$8 "% exceeds threshold\"  -e \"SEVERITY=Warning\" -e \"OBJECT_NAME=JP1-Sys-Monitor\"" |"/bin/ksh" ;close("/bin/ksh")}' ;\
#echo "$cpu_usage_info"|awk -v cpu_cri_th=$cpu_monitor_critical_threshold -v ip_adress=$IM_server_IP '{ if(100-$8 >= cpu_cri_th)  print "/opt/jp1base/bin/jevsend -i 986 -d \"" ip_adress "\" -m  \"CPU average usage rate " 100-$8 "% exceeds critical threshold\"  -e \"SEVERITY=Error\" -e \"OBJECT_NAME=JP1-Sys-Monitor\"" |"/bin/ksh" ;close("/bin/ksh")}' )&

#Process monitor
#1 the following is aix process name monitor, if process name is found in ps -ef command output,then consider this process exsits.
    all_process_status=$(ps aux)
    #echo "$all_process_status"
    for i in ${linux_processes_name_monitor[@]}        
          do 
          #echo "array member - $i"
          #process name is in the ninth column or the eighth column because May 01 occupy two column while 0:00 occupy one column
          died_pocess=$(echo "$all_process_status"|awk -v pattern=$i 'BEGIN{n=0} $11~pattern {++n } END {if (n==0) print"Monitored Process does not exist: " pattern }')
          if [ -n "$died_pocess" ];then
            #echo $died_pocess
            /opt/jp1base/bin/jevsend -i 994 -d "${IM_server_IP}" -m  "${died_pocess}"  -e "SEVERITY=Error" -e "OBJECT_NAME=JP1-AIX-Sys-Monitor"
          fi
    done
#2 process name and parameter monitor
   #echo "cde"
   #the parameter in the following command is wrapped in quotes, This tells the shell to ignore spaces in the arguments; 
   process_index=0
   for j in "${linux_processes_name_and_para_monitor[@]}"        
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




#the following is diskspace usage rate monitor  --remove %|print from second line to the last line and remove % character on the first match
df  -P | grep % |sed -n '2,$ s/%//p'|awk  -v disk_th=$disk_usage_rate_threshold -v disk_critical_th=$disk_usage_rate_critical_threshold '{if ($5>=disk_th && $5<disk_critical_th)  printf "Diskspace usage rate %s%% exceeds threshold on file system %s \n",  $5,$6}'>/etc/opt/jp1base/JP1_monitor_result4.txt
df  -P | grep % |sed -n '2,$ s/%//p'|awk  -v disk_critical_th=$disk_usage_rate_critical_threshold '{if ($5>=disk_critical_th) printf "Diskspace usage rate %s%% exceeds critical threshold on file system %s \n",  $5,$6}'>/etc/opt/jp1base/JP1_monitor_result6.txt

#the following is inode usage rate monitor  --remove %|print from second line to the last line and remove % character on the first match
df  -i -P | grep % |sed -n '2,$ s/%//p'|awk  -v inode_th=$inode_usage_rate_threshold -v inode_critical_th=$inode_usage_rate_critical_threshold '{if ($5>=inode_th && $5<inode_critical_th)  printf "Inode usage rate %s%% exceeds threshold on file system %s \n",  $5,$6}'>/etc/opt/jp1base/JP1_monitor_result3.txt
df  -i -P | grep % |sed -n '2,$ s/%//p'|awk  -v inode_critical_th=$inode_usage_rate_critical_threshold '{if ($5>=inode_critical_th) printf "Inode usage rate %s%% exceeds critical threshold on file system %s \n",  $5,$6}'>/etc/opt/jp1base/JP1_monitor_result5.txt


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
