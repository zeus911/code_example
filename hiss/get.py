#-*- coding: UTF-8 -*- 
#!/usr/bin/python

import cx_Oracle
import os,datetime
os.environ['NLS_LANG'] = 'SIMPLIFIED CHINESE_CHINA.UTF8'

import sys
reload(sys)
sys.setdefaultencoding("utf-8")

import smtplib,string
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.image import MIMEImage

db_info = {
  'username' : 'stagetest',
  'password' : 'Bb919189',
  'ip' : '192.168.31.225',
  'sid' : 'v6fix'
}

mail_info = {
  'smtp_host' : 'smtp.exmail.qq.com',
  'port' : '25',
  'username' : 'monitor@xinxindai.com',
  'password' : 'yhblsqt520',
  'from' : 'monitor@xinxindai.com',
  'to' : 'huangchao@xinxindai.com',
  'subject' : u'报表'
}

select_sql = """
select a.userid||','||b.realname||','||a.mobile||','||a.expiredate||','||c.gender||','||b.idcardno||','||d.servicenum
  from (select t.userid, to_char(t.expiredate, 'yyyy-mm-dd hh24:mi:ss') expiredate, t.mobile
          from stagetest.xxd_user t
         where t.expiredate >= trunc(sysdate - 7)
           and t.expiredate < sysdate) a
  left join (select t.userid, t.idcardno, t.realname
               from stagetest.xxd_realname_appro t
              where t.idcardtype = '1'
                and t.status = '1') b
    on a.userid = b.userid
  left join (select t.userid,
                    decode(t.gender, '1', '男', '0', '女') gender
               from stagetest.xxd_user_baseinfo t) c
    on a.userid = c.userid
  left join (select t.userid, t.servicenum
               from stagetest.xxd_vip_appro t
              where t.status = '1'
                and (t.servicenum not like 'FD%' and t.servicenum not like 'XXD%') ) d
    on a.userid = d.userid
 where a.userid not in
 (
  select t.userid 
   from stagetest.xxd_borrow_tender t
  where t.addtime >= trunc(sysdate - 7)
    and t.addtime < sysdate
    and t.status in ('1', '2')
    and t.isoptimize = '0'
 union all
 select p.userid
   from stagetest.xxd_trade_pack p
  where p.addtime >= trunc(sysdate - 7)
    and p.addtime < sysdate
 union all
 select o.userid
   from stagetest.xxd_optimize_userscheme o
  where o.status in ('1', '6', '7')
    and o.addtime >= trunc(sysdate - 7)
    and o.addtime < sysdate
 )
 order by 1
"""

def send_mail(smtp_host,port,username,password,from_addr,to_addr,msg_context,accessory,localday):
  server = smtplib.SMTP()
  msgRoot = MIMEMultipart('related')
  msgRoot['Subject'] = mail_info['subject']
  msgRoot['From'] = mail_info['from']
  msgRoot['To'] = mail_info['to']
  msgText = MIMEText('%s'%msg_context,'html','gbk')
  msgRoot.attach(msgText)
  att = MIMEText(open('%s'%accessory,'rb').read(),'base64','gbk')
  att["Content-Type"] = "application/octet-stream"
  att["Content-Disposition"] = "attachment; filename=%s.csv" %localday
  msgRoot.attach(att)
  try:
    server.connect(smtp_host,port)
    server.login(username,password)
    server.sendmail(from_addr,to_addr.split(','),msgRoot.as_string())
    server.quit()
  except Exception as e:
    print 'Connect mail server fail: %s' %e

def db_connect(ip,username,password,sid):
  try:
    conn = cx_Oracle.connect(username+'/'+password+'@'+ip+'/'+sid)
    cursor = conn.cursor()
    return cursor
  except Exception as e:
    conn.close()
    print "connect db fail: %s" %e

def select_db(sql):
  try:
    cursor = db_connect(db_info['ip'],db_info['username'],db_info['password'],db_info['sid'])
    cursor.execute(sql)
    rows = cursor.fetchall()
    return rows
  except cx_Oracle.OperationalError as e:
    print "select error: %s" %e
  finally:
    cursor.close()



if __name__ == "__main__":
  result = select_db(sql)
  localdir = os.getcwd()
  save_dir = os.path.join(localdir,'date')
  localday = datetime.datetime.now().strftime('%Y-%m-%d')
  last_7_day = datetime.timedelta(days=7)
  lastday = (datetime.datetime.now() - last_7_day).strftime('%Y-%m-%d')
  save_file = os.path.join(save_dir,localday)
  if not os.path.isdir(save_dir):
    try:
      os.makedirs(save_dir)
    except OSError as e:
      print 'make dir failed: %s' %e
  try:
    f = open(save_file,'w+')
    file_header = 'userid,真实姓名,手机号码,注册时间,性别,身份证号,客服号'
    f.write(file_header.encode('gbk')+'\n')
    for r in result:
      f.write(r[0].encode('gbk')+'\n')
    f.close()
    mail_context = u'%s至%s数据' %(lastday,localday)
    send_mail(mail_info['smtp_host'],mail_info['port'],mail_info['username'],mail_info['password'],mail_info['from'],mail_info['to'],mail_context,save_file,localday)
  except Exception as e:
    print e
  	
