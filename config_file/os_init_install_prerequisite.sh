
      mkdir -p ~/.ssh
      cat > ~/.ssh/id_rsa <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAxlc7TdTYBKeVh1pH2gkb6vJL1D3ZcEa36UksqAZPcYuKuMoP
zz+gtdtWMsGCbRkQ3X8GF8U5GOqp+sgM7z8lWH3lr6BHhJ53ncjUDBg0m89piKUE
VB+mSOWXb6Kbuobrj2tyvjgGHVTuK4Cy3faWJaViJ4G0mTVZguZaE/uB0eXGpq4E
2Be5sm6MK10gmrjgoyU0mi4RQSHQ0vBIe5vdnZqxnFi3X+cWWiyx5JM4BWt7YrTE
vRVK74y/4HYOaswg+x3s4yf/xlw82J/s9frUrSdQyGu2Il8qERyKjweuox1WH5zC
fFIg5dRDRSz/QmzpIbEIPkmbqkEL7FswMLNC3wIDAQABAoIBAGpRNC7iWvETy+mE
EWPk4hwsyUz54mZ24fqhCNkAmPEqda/cUGEtoD4bVrdaV0mX2ByDDIcNZy/eCkOt
nJFabfBjfA2KgwupzkC7+D6LcxfaNJ3Upt9ZH8+Pkn960LNJw1dbp2Qjr9NlRU34
bOjiV1XSsyyuMFq36EVsqPhxJwOVjtxSRu6je1J3QjmMobx3r2cUFlB4Gmh0hs48
1pfPoF+nF2AYyJ2lAw78dGCDCLlX+glU0pBtUHyBzb+UIRN17uhxhwnqV7GUq45a
XvMkH+erunk3bZ1lb/2/NXqoNIWcJ+x9l2qZrFvZvFlrJIM9U9gXQo0QP7YdewtY
RoxXnPECgYEA+msRVsMT4EkipXAUxZC0qbHbWWCgjE/dtov45d/Ghl0nnGAabKIW
voAWDawpJPNXutA6Qn8dPZmLIScXB7CRsSeASR3gtmT6VUFdtuZ2jdUP2o+bkJXr
5P57I/XPPHUwnHVNC+HJskwvJlby/tEKZhb7WZSxTPKvbT8qZpNmtYsCgYEAysMA
EYvDuNZ748+QY0BIBA6/Rb7NyUNqUnw5VBZ9f9UN7cnKAwvzOrA/sA/1wvAGsrPN
1OJ0+j6n7VQb4IflN6dsQ+spdKNMyuahrcdSWgaLBX8QBTduDn9Y1x05NbnZVH/Y
Ufc7pZuJ+VTVlZhMutKL3RCskyuo/SCgBTvlmn0CgYEAvLxJeyzYJCi69hl9blHb
+DHWcoyDNH1VSyo/03FO/SHkotVD1TBtF/MNrAxfjjvhmSkrX8bSUQUSeVAu6VrI
085Dv9fG73E3w13atekI3WkB4+ZshxKXkiXCxZ2ULardkm5OPXBVRg5pUuohhrAi
uEMF+cQ5xRb75MjAukLKHHUCgYBE4z+QtoWGtQhee9S4g8xz5HbDwXG1IXxsDdyE
XyfAWKhk05wYsOSwWdUpgiKjWl1MNZ6G53GK2+K91UerX0BXSkCUSr9I63pZrUXc
/s1R3Ms60NKmkxCHSGjsnPck88GM3eqm3nKbb17PIS13p8jZ6FKwhsu7LKg7Z+w2
GwWFGQKBgQDRlQThe0AjF52LnefsJqmw5r0HbATMhJ9iB/IN9S2wJrkZ8/VxSzeT
5y9Zo/eRoqzeTw5VxQQ0yC44rf2keaIrM4Sg+vEn0toxlP3agqP6XRFe4ZtLN7JB
7aI0ylEdtreoGl5QVV5/dL7BU93VThNbCjhoYQpIFzJEflxzsTKzmA==
-----END RSA PRIVATE KEY-----
EOF
        chmod 700 ~/.ssh/id_rsa
        mkdir -p ~/git
        cd ~/git
        git clone git@github.com:webloginwu/my_doc.git
        git clone git@github.com:webloginwu/code_example.git

       sudo sh -c "echo 127.0.1.1 $HOSTNAME   >>/etc/hosts"
       #ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -N '' #rsa section
       #ssh-copy-id -i ~/.ssh/id_rsa.pub frank@40.114.78.241

