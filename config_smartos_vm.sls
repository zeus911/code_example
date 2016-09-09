/opt/local/etc/pkgin/repositories.conf:
  file.managed:
    - source: salt://pkgin_repositories.conf
    - user: root
    - group: root
    - mode: 644

update_repository:
  cmd.run:
    - name: pkgin -fy up
    - timeout: 1200
#    - onchanges:
#      - file: /opt/local/etc/pkgin/repositories.conf
    - require:
       - file: /opt/local/etc/pkgin/repositories.conf
base-package:
  pkg.installed:
    - name: salt
    - require:
       - cmd: update_repository
  service.running:
    - name: salt:minion
    - enable: True