#also support cygwin
# uncomment the following setting in ~/.bashrc
# Some people use a different file for aliases
# if [ -f "${HOME}/.bash_aliases" ]; then
#   source "${HOME}/.bash_aliases"
# fi


./alias_content.sh
chmod +x ~/.bash_aliases
echo ". ~/.bash_aliases" >>~/.zshrc
