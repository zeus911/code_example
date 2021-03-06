

chunter_rsyslog:
  file.managed:
    - name: /opt/custom/etc/rsyslog.d/chunter_rsyslog.conf
    - contents: |

       #$ModLoad imfile
       #$InputFilePollInterval 10
       $WorkDirectory /var/run
       # File access
       $InputFileName /var/log/chunter/console.log
       $InputFileTag chunter-console
       $InputFileStateFile fifo-chunter-console-statefile
       $InputFileSeverity info
       $InputFileFacility local6
       #$InputFilePersistStateInterval 1
       $InputRunFileMonitor
       
       $InputFileName /var/log/chunter/crash.log
       $InputFileTag chunter-crash
       $InputFileStateFile fifo-chunter-crash-statefile
       $InputFileSeverity info
       $InputFileFacility local6
       #$InputFilePersistStateInterval 1
       $InputRunFileMonitor
       
       
       $InputFileName /var/log/chunter/run_erl.log
       $InputFileTag chunter-run_erl
       $InputFileStateFile fifo-chunter-run_erl-statefile
       $InputFileSeverity info
       $InputFileFacility local6
       #$InputFilePersistStateInterval 1
       $InputRunFileMonitor
       
       $InputFileName /var/log/chunter/error.log
       $InputFileTag chunter-error
       $InputFileStateFile fifo-chunter-error-statefile
       $InputFileSeverity info
       $InputFileFacility local6
       #$InputFilePersistStateInterval 1
       $InputRunFileMonitor

       $InputFileName /var/svc/log/network-chunter:default.log
       $InputFileTag chunter-svcadm
       $InputFileStateFile fifo-chunter-svc-statefile
       $InputFileSeverity info
       $InputFileFacility local6
       #$InputFilePersistStateInterval 1
       $InputRunFileMonitor
       
       #$template HostAudit, "/var/log/rsyslog/%HOSTNAME%/webservices.log"
       #$template auditFormat, "%msg%\n"
       local6.*                                @10.20.2.200:514      
    - backup: minion
    - makedirs: True

clear_rsyslog_state_and_restart:
  cmd.run:
    - name: |
       svcadm disable svc:/system/system-log:default
       sleep 5
       rm /var/run/fifo-chunter*
       svcadm enable svc:/system/system-log:default
       
    - onchanges: 
       - file: chunter_rsyslog
    - shell: '/usr/bin/bash'

           
    
    
    