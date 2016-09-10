#salt-ssh -i samrtos-dataset state.sls config_smartos_vm

/opt/local/etc/pkgin/repositories.conf:
  file.managed:
    - source: salt://pkgin_repositories.conf
    - user: root
    - group: root
    - mode: 644

update_repository:
  cmd.run:
    - name: |
        curl -O https://project-fifo.net/fifo.gpg
        gpg --primary-keyring /opt/local/etc/gnupg/pkgsrc.gpg --import < fifo.gpg
        gpg --keyring /opt/local/etc/gnupg/pkgsrc.gpg --fingerprint
        VERSION=rel
        cp /opt/local/etc/pkgin/repositories.conf /opt/local/etc/pkgin/repositories.conf.original
        echo "http://10.75.1.50/pkgin2016Q1-fifo" >> /opt/local/etc/pkgin/repositories.conf
        echo "http://10.75.1.50/pkgin2016Q1" >> /opt/local/etc/pkgin/repositories.conf
        pkgin -fy up
        pkgin -y install coreutils sudo gawk gsed
    - timeout: 1200
#   - onchanges:
#      - file: /opt/local/etc/pkgin/repositories.conf
    - require:
       - file: /opt/local/etc/pkgin/repositories.conf
base-package:
  pkg.installed:
    - pkgs:
      - leo_manager
      - leo_gateway
      - leo_storage
      - salt
    - require:
       - cmd: update_repository
  service.running:
    - name: salt:minion
    - enable: True