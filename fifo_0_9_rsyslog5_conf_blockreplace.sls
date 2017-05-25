

rsyslog.conf-blockreplace:
  file.blockreplace:
    - name: /etc/rsyslog.conf
    - marker_start: "# BLOCK TOP : added by wujunrong"
    - marker_end: "# BLOCK BOTTOM : added by wujunrong" 
    - content: |

            #gloable(workDirectory="/var/spool")
            #module(load="imfile" ) #needs to be done just once
            
            # File 1
            #input(type="imfile"  file="/data/sniffle/log/console.log"  tag="sniffle-console" Severity="info"  Facility="local6")
            #input(type="imfile"  file="/data/sniffle/log/run_erl.log"  tag="sniffle-run_erl" Severity="info"  Facility="local6")
            #input(type="imfile"  file="/data/sniffle/log/crash.log"    tag="sniffle-crash" Severity="info"  Facility="local6")
            #input(type="imfile"  file="/data/sniffle/log/error.log"    tag="sniffle-error" Severity="info"  Facility="local6")
            #
            #input(type="imfile"  file="/data/howl/log/console.log"     tag="howl-console" Severity="info"  Facility="local6")
            #input(type="imfile"  file="/data/howl/log/crash.log"       tag="howl-crash" Severity="info"  Facility="local6")
            #input(type="imfile"  file="/data/howl/log/error.log"       tag="howl-error" Severity="info"  Facility="local6")
            #input(type="imfile"  file="/data/howl/log/run_erl.log"     tag="howl-run_erl" Severity="info"  Facility="local6")
            #
            #
            #input(type="imfile"  file="/data/snarl/log/console.log"     tag="snarl-console" Severity="info"  Facility="local6")
            #input(type="imfile"  file="/data/snarl/log/crash.log"       tag="snarl-crash" Severity="info"    Facility="local6")
            #input(type="imfile"  file="/data/snarl/log/error.log"       tag="snarl-error" Severity="info"    Facility="local6")
            #input(type="imfile"  file="/data/snarl/log/run_erl.log"     tag="snarl-run_erl" Severity="info"  Facility="local6")
            #
            #local6.*                                @@10.0.1.38:514

            
            #$ModLoad imfile
            #$InputFilePollInterval 10
            $WorkDirectory /var/run
            
            {% set all_fifo_modules = ['snarl', 'sniffle','howl'] %}
            {% for fifo_module in all_fifo_modules %}
            

            # File access
            $InputFileName /data/{{ fifo_module }}/log/console.log
            $InputFileTag {{ fifo_module }}-console
            $InputFileStateFile fifo-{{ fifo_module }}-console-statefile
            $InputFileSeverity info
            $InputFileFacility local6
            #$InputFilePersistStateInterval 1
            $InputRunFileMonitor
            
            $InputFileName /data/{{ fifo_module }}/log/crash.log
            $InputFileTag {{ fifo_module }}-crash
            $InputFileStateFile fifo-{{ fifo_module }}-crash-statefile
            $InputFileSeverity info
            $InputFileFacility local6
            #$InputFilePersistStateInterval 1
            $InputRunFileMonitor
            
            
            $InputFileName /data/{{ fifo_module }}/log/run_erl.log
            $InputFileTag {{ fifo_module }}-run_erl
            $InputFileStateFile fifo-{{ fifo_module }}-run_erl-statefile
            $InputFileSeverity info
            $InputFileFacility local6
            #$InputFilePersistStateInterval 1
            $InputRunFileMonitor
            
            $InputFileName /data/{{ fifo_module }}/log/error.log
            $InputFileTag {{ fifo_module }}-error
            $InputFileStateFile fifo-{{ fifo_module }}-error-statefile
            $InputFileSeverity info
            $InputFileFacility local6
            #$InputFilePersistStateInterval 1
            $InputRunFileMonitor
 
            $InputFileName /data/{{ fifo_module }}/log/erlang.log.1
            $InputFileTag {{ fifo_module }}-erlang_log
            $InputFileStateFile fifo-{{ fifo_module }}-erlang_log-statefile
            $InputFileSeverity info
            $InputFileFacility local6
            #$InputFilePersistStateInterval 1
            $InputRunFileMonitor

            {% endfor %}

            #$template HostAudit, "/data/rsyslog/%HOSTNAME%/webservices.log"
            #$template auditFormat, "%msg%\n"
            local6.*                                @@10.0.1.38:514   



    - show_changes: True
    - append_if_not_found: True
    - backup: '.bak'

setfifo_rsyslog.conf:
  cmd.run:
    - name: |
       svcadm disable svc:/system/system-log:default
       sleep 5
       rm /var/run/fifo-*statefile
       svcadm enable svc:/system/system-log:default
    - onchanges: 
       - file: rsyslog.conf-blockreplace
    - shell: '/usr/bin/bash'

           
    
    
    