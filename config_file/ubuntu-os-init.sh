apt-get update
apt-get -y install proxychains
cp /etc/proxychains.conf etc/proxychains.conf.$(date "+%b_%d_%Y_%H.%M.%S")
sed 's/socks4  127.0.0.1 8000/socks5  127.0.0.1 1080/' /usr/local/etc/proxychains.conf
proxychains4 apt-get -y install tree lrzsz dos2unix build-essential autoconf telnet screen vim  dnsutils tftp git openssh-server aria2 autossh proxychains curl iotop zsh zssh
proxychains4 curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh 
    cp ~/.zshrc ~/.zshrc.bak.$(date "+%b_%d_%Y_%H.%M.%S")
    sed -i  's/^  git/  history dircycle/' ~/.zshrc
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="afowler"/'  ~/.zshrc