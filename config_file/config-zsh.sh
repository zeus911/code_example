    #!/bin/bash
    cp ~/.zshrc ~/.zshrc.bak.$(date "+%b_%d_%Y_%H.%M.%S")
    sed -i  's/^  git/  history dircycle systemd autosuggestions/' ~/.zshrc
    #sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="afowler"/'  ~/.zshrc
    
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/'  ~/.zshrc
    
    #install font method1:
    #https://medium.com/@Andreas_cmj/how-to-setup-a-nice-looking-terminal-with-wsl-in-windows-10-creators-update-2b468ed7c326
    #on windows10 download and doble click to  exec ttf file,and change wsl terminal's font to DejaVu Sans Mono for Powerline
    #https://github.com/powerline/fonts/blob/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf
    
    #install font method2:
      #only needed to be run on windows10(wsl) or macos(iterm2)
  
        # cd ~
        # git clone git@github.com:powerline/fonts.git
        # cd fonts
        # ./install.sh

     #iterm2->Preferences->Profiles->Text->Font->Change Font->Droid Sans Mono for Powerline

    cd ~/.oh-my-zsh/custom/plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions

    mkdir -p ~/.zsh-my-plugin
    cd ~/.zsh-my-plugin
    git clone https://github.com/seebi/dircolors-solarized 
    echo 'eval `dircolors  ~/.zsh-my-plugin/dircolors-solarized/dircolors.256dark`' >> ~/.zshrc
    