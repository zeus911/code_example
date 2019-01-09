#ssh-add ~/.ssh/id_rsa_frank_private
#sudo passwd root

sudo sh -c  'echo "frank ALL=(ALL) NOPASSWD: ALL" >> /private/etc/sudoers.d/frank_sudo'

sudo chown -R $(whoami) /usr/local/lib/pkgconfig
brew install lrzsz zsh zsh-completions telnet autossh proxychains-ng


cp /usr/local/etc/proxychains.conf /usr/local/etc/proxychains.conf.$(date "+%b_%d_%Y_%H.%M.%S")
sudo sed -i .bak 's/9050/1080/g' /usr/local/etc/proxychains.conf

proxychains4 curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh |  source /dev/stdin
