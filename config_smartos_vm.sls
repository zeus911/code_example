/opt/local/etc/pkgin/repositories.conf:
  file.managed:
    - source: 
      - salt://pkgin_repositories.conf
    - user: root
    - group: root
    - mode: 644


mustang_shell_script:
  file.managed:
    - name: /root/mustang.sh
    - source: salt://mustang.sh
    - user: root
    - group: root
    - mode: 755    
    
mustang_package:
  file.managed:
    - name: /root/mustang-Main.tar.gz
    - source: salt://mustang-Main.tar.gz
    - user: root
    - group: root
    - mode: 744 



taurus_shell_script:
  file.managed:
    - name: /root/taurus.sh
    - source: salt://taurus.sh
    - user: root
    - group: root
    - mode: 755    
    

    
install_mustang:
  cmd.run:
    - name: |
       #sleep 240
       #pkgin -fy up
       sed -i.bak "s/VERIFIED_INSTALLATION=.*/VERIFIED_INSTALLATION=never/" /opt/local/etc/pkg_install.conf
       /root/mustang.sh  /root/mustang-Main.tar.gz
       /root/taurus.sh
    - timeout: 1200
#   - onchanges:
#      - file: /opt/local/etc/pkgin/repositories.conf
    - require:
       - file: mustang_shell_script
       - file: mustang_package
       - file: taurus_shell_script
base-package:
  service.running:
    - name: salt:minion
    - enable: True
    - require:
       - cmd: install_mustang
