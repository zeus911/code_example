    #!/bin/bash
    cp ~/.zshrc ~/.zshrc.bak.$(date "+%b_%d_%Y_%H.%M.%S")
    sed -i  's/^  git/  history dircycle systemd autosuggestions/' ~/.zshrc
    #sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="afowler"/'  ~/.zshrc
    
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/'  ~/.zshrc
    #https://medium.com/@Andreas_cmj/how-to-setup-a-nice-looking-terminal-with-wsl-in-windows-10-creators-update-2b468ed7c326
    #on windows10 download and exec ttf file,and change wsl terminal's font to DejaVu Sans Mono for Powerline
    #https://github.com/powerline/fonts/blob/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf
    
    cd ~/.oh-my-zsh/custom/plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions

    mkdir -p ~/.zsh-my-plugin
    cd ~/.zsh-my-plugin
    git clone https://github.com/seebi/dircolors-solarized 
    echo 'eval `dircolors  ~/.zsh-my-plugin/dircolors-solarized/dircolors.256dark`' >> ~/.zshrc
    