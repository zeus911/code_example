
cat > ~/.bash_aliases <<'EOF'
          alias sdk='cd ~/repository_air_trace/AT_node_sdk/'
          alias dyn='cd ~/repository_air_trace/AT_node_sdk/testCloudArtifacts/DynamicOrg'
          alias parts='cd ~/repository_air_trace/AT_partstraceability'
          alias mfr='cd ~/repository_air_trace/AT_Manufacturer'
          alias data='cd ~/repository_air_trace/AT_node_sdk/deployScripts'
          alias deploy='cd ~/repository_air_trace/AT_deployment/deployWithDynConf'
          alias server='cd ~/repository_air_trace/AT_node_server'
          alias client='cd ~/repository_air_trace/AT_node_client'
          alias sshconfig='cat ~/.ssh/config'
          alias viansible='sudo vi /etc/ansible/hosts'
          alias test='cd ~/repository_air_trace/AT_node_sdk/deployScripts'
          alias log='cd /var/log/nginx'
          alias dp='sudo docker ps -a'
          alias dpn='sudo docker ps --format "{{.Names}},{{.Status}},{{.Ports}}" -a | column -t -s ,'
          alias dla='sudo docker logs sdk'
          alias dl='sudo docker logs'
          alias de='sudo docker exec -e COLUMNS="___tput cols___" -e LINES="___tput lines___" -ti'
          alias ds='sudo docker start'
          alias dr='sudo docker restart'
          alias nconfig='cd /etc/nginx/sites-enabled/'
          alias rnd='sudo docker restart app_nginx'
          alias rn='sudo systemctl restart nginx.service'
          alias ltr='sudo ls -ltr'
          alias vpn='autossh -M 2000 -D localhost:1080  frank@40.114.78.241'
EOF
    chmod +x ~/.bash_aliases
	echo ". ~/.bash_aliases" >>~/.bashrc
    echo ". ~/.bash_aliases" >>~/.zshrc
	source ~/.zshrc
