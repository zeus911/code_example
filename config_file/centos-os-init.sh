
systemctl stop firewalld
systemctl disable firewalld
systemctl status firewalld


yum update
yum -y install git

cd ~
sudo yum -y groupinstall  "Development Tools"
git clone https://github.com/rofl0r/proxychains-ng.git
cd proxychains-ng/
./configure
make 
sudo make install
sudo make install-config
cp /usr/local/etc/proxychains.conf /usr/local/etc/proxychains.conf.$(date "+%b_%d_%Y_%H.%M.%S")
sudo sed -i 's/9050/1080/g' /usr/local/etc/proxychains.conf

proxychains yum -y install tftp epel-release wim wget curl telnet lrzsz aria2 openssh-clients openssh-server iotop net-tools lsof tcpdump tree tcpdump zip unzip less dos2unix git iproute bind-utils autossh iproute proxychains zsh zssh vim nmap
proxychains curl -o ./zsh_install.sh -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh 
    chmod +x  ./zsh_install.sh
    ./zsh_install.sh

