#!/bin/bash
set -e

dnf install -y ypbind
systemctl enable rpcbind
systemctl enable ypbind


cat >> /etc/sysconfig/network <<EOL
NISDOMAIN="robotica.itam.mx"
EOL

cat >> /etc/yp.conf << EOL
domain robotica.itam.mx server hidrogeno
EOL

if [ $1 -ge 28 ] ; then
	dnf --enablerepo=updates-testing update authselect
	authselect select nis with-mkhomedir
fi
ypdomainname robotica.itam.mx
authconfig --enablenis --nisdomain=robotica.itam.mx --nisserver=hidrogeno.itam.mx --enablemkhomedir --update

systemctl start rpcbind ypbind 
systemctl enable rpcbind ypbind 
service ypbind start

cat >> /usr/libexec/ypbind-pre-setdomain <<EOL
echo “ypbind is not ready… sleep 10 seconds…”	
sleep 10
EOL
