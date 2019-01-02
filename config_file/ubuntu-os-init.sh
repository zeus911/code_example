proxychains4 apt-get -y install tree lrzsz dos2unix build-essential autoconf telnet screen vim  dnsutils tftp git openssh-server aria2 autossh proxychains curl iotop zsh zssh
proxychains4 curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh 
    cp ~/.zshrc ~/.zshrc.bak.$(date "+%b_%d_%Y_%H.%M.%S")
    sed -i  's/^  git/  history dircycle/' ~/.zshrc
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="afowler"/'  ~/.zshrc