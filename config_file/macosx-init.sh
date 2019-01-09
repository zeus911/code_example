#ssh-add ~/.ssh/id_rsa_frank_private
#sudo passwd root

sudo sh -c  'echo "fwu066 ALL=(ALL) NOPASSWD: ALL" >/private/etc/sudoers.d/frank_sudo'
# setup sock4 proxy
    sudo chown -R $(whoami) /usr/local/lib/pkgconfig
    brew install lrzsz zsh zsh-completions telnet autossh proxychains-ng

    cp /usr/local/etc/proxychains.conf /usr/local/etc/proxychains.conf.$(date "+%b_%d_%Y_%H.%M.%S")
    sudo sed -i .bak 's/9050/1080/g' /usr/local/etc/proxychains.conf


#setup https proxy using go which is based on sock5 proxy
  #setup go proxy
    http_proxy=socks5://127.0.0.1:1080 go get -v golang.org/x/net/proxy
    git config --global http.proxy socks5://127.0.0.1:1080
    go get github.com/elazarl/goproxy
    go get -v golang.org/x/net/proxy
    git config --global --unset http.proxy

  #setup https proxy
    proxychains4 git clone https://github.com/chinglinwen/s2http.git
    cd s2http

    go build main.go
    ./main  -socks 127.0.0.1:1080 -port 2080 -v

    export https_proxy='https://127.0.0.1:2080/'

#install zsh
    curl -o ./zsh_install.sh -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh 
    chmod +x  ./zsh_install.sh
    ./zsh_install.sh

    cp ~/.zshrc ~/.zshrc.bak.$(date "+%b_%d_%Y_%H.%M.%S")
    sed -i .bak 's/^  git/  history dircycle zsh-autosuggestions/' ~/.zshrc
    sed -i .bak 's/ZSH_THEME="robbyrussell"/ZSH_THEME="afowler"/'  ~/.zshrc
    source ~/.zshrc