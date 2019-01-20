    cp ~/.zshrc ~/.zshrc.bak.$(date "+%b_%d_%Y_%H.%M.%S")
    sed -i  's/^  git/  history dircycle systemd autosuggestions/' ~/.zshrc
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="afowler"/'  ~/.zshrc
    
    cd ~/.oh-my-zsh/custom/plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions

    mkdir -p ~/.zsh-my-plugin
    cd ~/.zsh-my-plugin
    git clone https://github.com/seebi/dircolors-solarized 
    echo 'eval `dircolors  ~/.zsh-my-plugin/dircolors-solarized/dircolors.256dark`' >> ~/.zshrc
    