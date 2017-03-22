VERSION=rel
echo "http://release.project-fifo.net/pkg/${VERSION}" >> /opt/local/etc/pkgin/repositories.conf
curl -O https://project-fifo.net/fifo.gpg
gpg --primary-keyring /opt/local/etc/gnupg/pkgsrc.gpg --import < fifo.gpg
gpg --keyring /opt/local/etc/gnupg/pkgsrc.gpg --fingerprint
pkgin -fy up
pkgin -y  install  dalmatinerfe dalmatinerdb
svcadm enable epmd
svcadm enable dalmatiner/db  
svcadm enable dalmatiner/fe
svcs epmd dalmatiner/db dalmatiner/fe
