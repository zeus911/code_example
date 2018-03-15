
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get -y update
sudo apt-get -y install docker-ce
sudo apt-get -y install docker-compose
#``````
wget https://redirector.gvt1.com/edgedl/go/go1.9.2.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.9.2.linux-amd64.tar.gz

sudo cp /etc/profile /etc/profile.bak
sudo sh -c "echo 'GOPATH=/usr/local/go' >> ~/.profile"
sudo sh -c "echo 'PATH=\$PATH:\$GOPATH/bin' >>  ~/.profile"
. ~/.profile
echo $GOPATH
#````
sudo apt-get -y install npm  tree lrzsz
npm version
sudo npm install npm@3.10.10 -g
#````
#Node.js - version 6.9.x or greater
#Node.js version 7.x is not supported at this time.
sudo curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get -y install nodejs


#ansible 'org12-AT' -m shell -a "cd ~/repository_air_trace/AT_node_client  && pwd && sudo npm rebuild node-sass --force"
#client side initialize
cd ~/repository_air_trace/AT_node_client; \
npm -v;sudo npm install -g npm@5.3.0; sudo  npm install -g @angular/cli@1.2.0 ;sudo npm install; \
npm rebuild node-sass --force; 


sudo apt-get -y update
sudo apt-get -y install nginx

sudo tee /etc/nginx/conf.d/air-trace.conf<<'EOF'
server {
    error_log /var/log/nginx/error.log info;
    rewrite_log on;
    listen       4200 default_server;
#        listen       [::]:80 default_server;
    server_name  _;
    root         /var/www/html;
    # Load configuration files for the default server block.
    include /etc/nginx/default.d/*.conf;
    location / {
             index  index.html;
             error_log /var/log/nginx/location-error.log info;
             root  /var/www/html;
             #try_files $uri $uri/index.html;
             autoindex on;
    }
    error_page 404 /index.html;
        location = /index.html {
              root  /var/www/html;
              internal;
    }
#   error_page 404 /404.html;
#       location = /40x.html {
#   }
    error_page 500 502 503 504 /50x.html;
        location = /50x.html {
    }
}
EOF
sudo systemctl restart nginx.service

sudo apt install -y python-pip
pip install --upgrade pip
sudo pip install jinja2
sudo apt install -y jq

# cd /home/org13/repository_air_trace/AT_node_client/
# npm rebuild node-sass --force



#ubuntu
echo "=========install selenium ========"
#https://medium.com/@griggheo/running-selenium-webdriver-tests-using-firefox-headless-mode-on-ubuntu-d32500bb6af2
sudo apt-get install -y python-pip
pip install --upgrade pip
sudo pip install selenium # 或sudo -H pip install selenium
sudo apt-get install -y firefox xvfb
Xvfb :10 -ac &
export DISPLAY=:10

#Test that you can run firefox in the foreground with no errors
#firefox
#(kill it with Ctrl-C)


#firefox
wget https://github.com/mozilla/geckodriver/releases/download/v0.19.0/geckodriver-v0.19.0-linux64.tar.gz
sudo sh -c 'tar -x geckodriver -zf  geckodriver-v0.19.0-linux64.tar.gz -O > /usr/bin/geckodriver'
sudo chmod +x /usr/bin/geckodriver

#ubuntu chrome,https://sites.google.com/a/chromium.org/chromedriver/home
wget https://chromedriver.storage.googleapis.com/2.36/chromedriver_linux64.zip
sudo apt-get install  -y unzip
unzip chromedriver_linux64.zip
sudo cp chromedriver /usr/bin/
sudo chmod +x /usr/bin/chromedriver


#https://www.linuxbabe.com/ubuntu/install-google-chrome-ubuntu-16-04-lts
curl -sS -o - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get -y update
sudo apt-get -y install google-chrome-stable

echo "========= selenium installation complete========"