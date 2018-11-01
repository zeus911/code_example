#!/usr/bin/env bash
set -e

export zabbix=~/repository_air_trace/zabbix
mkdir -p $zabbix
cd $zabbix
cat > $zabbix/docker-compose.yaml <<'EOF'
version: '2'
services:
  #https://github.com/zabbix/zabbix-docker/tree/3.0/server-pgsql/ubuntu
  #https://hub.docker.com/r/zabbix/zabbix-server-pgsql/
  postgres-server:    # The Postgres Database Service
    image: postgres:latest
    restart: always
    environment:   # Username, password and database name variables
      POSTGRES_USER: zabbix
      POSTGRES_PASSWORD: zabbix
      POSTGRES_DB: zabbix
      #PG_DATA: /var/lib/postgresql/data/pgdata 
    ports:    # Port where Zabbix UI is available
      - 5432:5432
    volumes:  # Volumes for scripts and related files you can add
      - "${zabbix}/postgresql/data/pgdata:/var/lib/postgresql/data"


  zabbix-server:     # The main Zabbix Server Software Service
    image: zabbix/zabbix-server-pgsql:ubuntu-latest
    restart: always
    environment:   # The Postgres database value variable
      POSTGRES_USER: zabbix
      POSTGRES_PASSWORD: zabbix
      #POSTGRES_DB: zabbixNew
      ZBX_HISTORYSTORAGETYPES: log,text #Zabbix configuration variables
      ZBX_DEBUGLEVEL: 1
      ZBX_HOUSEKEEPINGFREQUENCY: 1
      ZBX_MAXHOUSEKEEPERDELETE: 5000
      DB_SERVER_HOST: zabbix_postgres-server_1
    ports:    # Port where Zabbix UI is available
      - 10051:10051
    depends_on:
      - postgres-server
    volumes:  # Volumes for scripts and related files you can add
      - /usr/lib/zabbix/alertscripts:/usr/lib/zabbix/alertscripts
  
  zabbix-web:    # The main Zabbix web UI or interface 
    image: zabbix/zabbix-web-nginx-pgsql:ubuntu-latest
    restart: always
    environment:  # Postgre database variables
      POSTGRES_USER: zabbix
      POSTGRES_PASSWORD: zabbix
      POSTGRES_DB: zabbix
      ZBX_SERVER_HOST: zabbix_zabbix-server_1  # Zabbix related and Php variables
      ZBX_POSTMAXSIZE: 64M
      PHP_TZ: "Asia/Shanghai"  
      ZBX_MAXEXECUTIONTIME: 500
    depends_on:
      - postgres-server
      - zabbix-server
    ports:    # Port where Zabbix UI is available
      - 3350:80
EOF
zabbix=~/repository_air_trace/zabbix
cd $zabbix
sudo -E docker-compose stop;yes | sudo -E docker-compose rm
#environment variables are not preserved by default when sodoing.https://forums.docker.com/t/docker-compose-not-seeing-environment-variables-on-the-host/11837/7
sudo -E docker-compose up -d