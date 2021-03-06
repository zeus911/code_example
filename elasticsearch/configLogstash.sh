logstash=~/repository_air_trace/logstash
mkdir -p $logstash/settings $logstash/pipeline $logstash/data
cd "$logstash"/pipeline/                            
cat > "$logstash"/pipeline/pipeline.conf <<EOF                         
input {
  syslog {
    port => 1514
    type => "orderer"
    #codec =>"json"
    grok_pattern => "(?<rsyslogtag>[a-zA-Z_\-0-9]+) (?<hostname>[a-zA-Z_\-0-9]+) %{GREEDYDATA:message}"
  }
  syslog {
    port => 2514
    type => "docker_log"
    #codec =>"json"
    grok_pattern => "(?<rsyslogtag>[a-zA-Z_\-0-9]+) (?<hostname>[a-zA-Z_\-0-9]+) %{GREEDYDATA:message}"

  }
  #rsyslog logstash  
  syslog {
    port => 3514
    type => "nginx-reverse-proxy_and-nginx-access"
    grok_pattern => "(?<rsyslogtag>[a-zA-Z_\-0-9]+) (?<hostname>[a-zA-Z_\-0-9]+) %{GREEDYDATA:message}"
  }  
  #zabbix logstash
  tcp {
    port => 4514
    codec => "json"
    add_field => {
     "rsyslogtag" => "zabbix-cpu" 
    }
  }
   
}

filter {

  if [rsyslogtag] =~ "orderer" { 
        json {
              source => "message"
        }  
        grok {
              #patterns_dir => ["/etc/logstash/custom_pattern"]
              #match => { "log" => "%{MY_DATE:log_time}" }
              match => { "log" => "(?<wutime>%{YEAR}-%{MONTHNUM}-%{MONTHDAY}[T ]%{HOUR}:%{MINUTE}:%{SECOND})" }

        }
         date {
              match => [ "wutime", "YYYY-MM-dd HH:mm:ss.SSS" ]
              target => "wutime"
        }      

  }

  if [rsyslogtag] == "sdk" { 
        json {
              source => "message"
        }  
        grok {
  	          #patterns_dir => ["/etc/logstash/custom_pattern"]
              #match => { "log" => "%{MY_DATE:log_time}" }
              match => { "log" => "(?<wutime>%{YEAR}-%{MONTHNUM}-%{MONTHDAY}[T ]%{HOUR}:%{MINUTE}:%{SECOND})" }

        }
         date {
              match => [ "wutime", "YYYY-MM-dd HH:mm:ss.SSS" ]
              target => "wutime"
        }      

  }

  if [rsyslogtag] == "manufacture_web" { 
        json {
              source => "message"
        }  
        grok {
              #patterns_dir => ["/etc/logstash/custom_pattern"]
              #match => { "log" => "%{Customized_MY_DATE:log_time}" }

              match => { "log" => "(?<wutime>%)\[%{GREEDYDATA:wutime}\]" }
        }
        date {
              match => [ "wutime", "dd/MMM/YYYY:HH:mm:ss Z" ]
              target => "wutime"
        }      

  }

  if [rsyslogtag] == "nginx-reverse-proxy" { 
       grok {
           
              match => { "message" => "\[%{GREEDYDATA:wutime}\] %{IP:source} %{GREEDYDATA:originate_domain_name}%{IP:reverse_proxy_IP}%{GREEDYDATA:target_url}upstream_response_time %{BASE10NUM:upstream_response_time} %{GREEDYDATA:ccc}request_time %{BASE10NUM:request_time}" }
       }
       date {
              match => ["wutime", "dd/MMM/YYYY:HH:mm:ss Z"]
              target => "wutime"
              #remove_field => "time_local"
      }
  }
  if [rsyslogtag] == "nginx-access" { 
       grok {
           #nginx config:log_format upstreamlog '[$time_local] $remote_addr - $remote_user - $server_name  to: $upstream_addr: $request upstream_response_time $upstream_response_time msec $msec request_time $request_time';
           match => { "message" => "\[%{GREEDYDATA:wutime}\] %{IP:source_ip} %{GREEDYDATA:remoteuser} %{GREEDYDATA:target_ip}  to: %{GREEDYDATA:url} upstream_response_time %{BASE16FLOAT:upstream_response_time} msec %{BASE16FLOAT:nginx_time} request_time %{BASE16FLOAT:request_time}" }
       }
       date {
             match => ["wutime", "dd/MMM/YYYY:HH:mm:ss Z"]
             target => "wutime"
             #remove_field => "time_local"
      }
  }

  if [rsyslogtag] == "zabbix-cpu" { 

       date {
             match => ["clock", "UNIX"]
       }
       mutate {
             convert => { "value" => "float" }
       }
  }


}

output {
   stdout { codec => rubydebug }

  
      elasticsearch {
      hosts => ["elasticsearch"]
      document_type => "%{type}"
      index => "%{rsyslogtag}-%{host}-%{+YYYY.MM.dd}"
      manage_template => false
      }
   
   #if [type] == "nginx-reverse-proxy" {
   #   elasticsearch {
   #   hosts => ["elasticsearch"]
   #   document_type => "%{type}"
   #   index => "%{type}-%{host}-%{+YYYY.MM.dd}"
   #   manage_template => false
   #   }
   #}

}
EOF