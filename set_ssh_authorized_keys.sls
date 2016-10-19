{% set host_pubkey_dict = salt['mine.get']('smartos_thinkpad.zhixiang,ocp09.thu.briphant.com', 'get_ssh_authorized_keys', 'list') %}
/root/.ssh/authorized_keys:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - contents: |
       {{ host_pubkey_dict['smartos_thinkpad.zhixiang'] }}
       {{ host_pubkey_dict['ocp09.thu.briphant.com'] }}