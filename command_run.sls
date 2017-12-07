generate_command_run_script_file:
  file.managed:
    - name: /root/command_run.sh
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - contents_pillar: command_run


   
run_command_script:
  cmd.run:
    - name: |      
        echo abc 
        cat /root/command_run.sh
        /root/command_run.sh
    - shell: /usr/bin/bash
    - timeout: 1800    
    - require:
      - file: generate_command_run_script_file
  
