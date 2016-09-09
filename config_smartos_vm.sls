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
salt:
  pkg.installed: []
