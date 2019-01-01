#cd  ./code_example/
   git commit -a -m "$1"
   git pull
   git push
   cp ssh-host-config ~/.ssh/config
cd ../
cd  ./my_doc
   git commit -a -m "$1"
   git pull
   git push

echo ssh-copy-id -i ~/.ssh/id_rsa.pub frank@40.114.78.241


