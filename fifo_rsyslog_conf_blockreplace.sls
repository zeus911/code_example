

rsyslog.conf-blockreplace:
  file.blockreplace:
    - name: /opt/local/etc/rsyslog.conf
    - marker_start: "# BLOCK TOP : added by wujunrong"
    - marker_end: "# BLOCK BOTTOM : added by wujunrong" 
    - content: |

            #gloable(workDirectory="/var/spool")
            module(load="imfile" ) #needs to be done just once
            
            # File 1
            input(type="imfile"  file="/data/sniffle/log/console.log"  tag="sniffle-console" Severity="info"  Facility="local6")
            input(type="imfile"  file="/data/sniffle/log/run_erl.log"  tag="sniffle-run_erl" Severity="info"  Facility="local6")
            input(type="imfile"  file="/data/sniffle/log/crash.log"    tag="sniffle-crash" Severity="info"  Facility="local6")
            input(type="imfile"  file="/data/sniffle/log/error.log"    tag="sniffle-error" Severity="info"  Facility="local6")
            
            input(type="imfile"  file="/data/howl/log/console.log"     tag="howl-console" Severity="info"  Facility="local6")
            input(type="imfile"  file="/data/howl/log/crash.log"       tag="howl-crash" Severity="info"  Facility="local6")
            input(type="imfile"  file="/data/howl/log/error.log"       tag="howl-error" Severity="info"  Facility="local6")
            input(type="imfile"  file="/data/howl/log/run_erl.log"     tag="howl-run_erl" Severity="info"  Facility="local6")
            
            
            input(type="imfile"  file="/data/snarl/log/console.log"     tag="snarl-console" Severity="info"  Facility="local6")
            input(type="imfile"  file="/data/snarl/log/crash.log"       tag="snarl-crash" Severity="info"    Facility="local6")
            input(type="imfile"  file="/data/snarl/log/error.log"       tag="snarl-error" Severity="info"    Facility="local6")
            input(type="imfile"  file="/data/snarl/log/run_erl.log"     tag="snarl-run_erl" Severity="info"  Facility="local6")
            
            local6.*                                @@10.0.1.38:514

    - show_changes: True
    - append_if_not_found: True
    - backup: '.bak'

setfifo_rsyslog.conf:
  cmd.run:
    - name: |
       svcadm disable svc:/pkgsrc/rsyslog:default
       rm /imfile-state\:-data-*
       svcadm enable svc:/pkgsrc/rsyslog:default
    - onchanges: 
       - file: rsyslog.conf-blockreplace
    - shell: /usr/bin/bash

           
    
    
    