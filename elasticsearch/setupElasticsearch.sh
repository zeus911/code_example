cat > ~/repository_air_trace/logstash/hosts <<EOF
127.0.0.1    localhost

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouter
EOF

kibana=~/repository_air_trace/kibana
mkdir -p $kibana
cat > $kibana/docker-compose.yaml <<EOF
version: '2'
services:
  kibana:
    container_name: kibana
    image: docker.elastic.co/kibana/kibana:6.4.0
    ports:
      - 3250:5601
  elasticsearch:
    container_name: elasticsearch
    image: docker.elastic.co/elasticsearch/elasticsearch:6.4.0
    ports:
      - 9200:9200
      - 9300:9300
    environment:
      - discovery.type=single-node
    volumes:
      - ~/repository_air_trace/elasticsearch:/usr/share/elasticsearch/data
  logstash:
    container_name: logstash
    image: docker.elastic.co/logstash/logstash:6.4.0
    ports:
      - 1514:1514
      - 2514:2514
      - 3514:3514
      - 4514:4514
    volumes:
      - ~/repository_air_trace/logstash/hosts:/etc/hosts
      - ~/repository_air_trace/logstash/pipeline/:/usr/share/logstash/pipeline/
      - ~/repository_air_trace/logstash/data/:/var/data
      - ~/repository_air_trace/logstash/etc/:/etc/logstash/custom_pattern 
    command: --config.reload.automatic
    #command: --debug --config.reload.automatic
    #--config.reload.automatic: if you change pipeline config logstash will restart automatically
EOF
kibana=~/repository_air_trace/kibana
cd $kibana/

kibana=~/repository_air_trace/kibana
cd $kibana/
sudo docker-compose up -d