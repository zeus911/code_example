#sed -i s/^sudo proxychains/sudo /g ./ubuntu-os-init.sh
sudo sh -c  'echo "frank ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/frank_sudo'
sudo apt-get update
sudo apt-get -y install proxychains
sudo cp /etc/proxychains.conf /etc/proxychains.conf.$(date "+%b_%d_%Y_%H.%M.%S")
sudo sed -i 's/socks4  127.0.0.1 8000/socks5  127.0.0.1 1080/' /etc/proxychains.conf
sudo proxychains apt-get -y install tree lrzsz dos2unix build-essential autoconf telnet screen vim  dnsutils tftp git openssh-server aria2 autossh proxychains curl iotop zsh zssh nmap
sudo proxychains curl -o ./zsh_install.sh -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh 
    chmod +x  ./zsh_install.sh
    ./zsh_install.sh
    cp ~/.zshrc ~/.zshrc.bak.$(date "+%b_%d_%Y_%H.%M.%S")
    sed -i  's/^  git/  history dircycle systemd autosuggestions/' ~/.zshrc
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="afowler"/'  ~/.zshrc
    
    cd ~/.oh-my-zsh/custom/plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions

    mkdir -p ~/.zsh-my-plugin
    cd ~/.zsh-my-plugin
    git clone https://github.com/seebi/dircolors-solarized 
    echo 'eval `dircolors  ~/.zsh-my-plugin/dircolors-solarized/dircolors.256dark`' >> ~/.zshrc