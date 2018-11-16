dnf install -y nfs-utils libnfs
systemctl start rpcbind 
systemctl enable rpcbind 
#vi /etc/fstab:
echo "open the file: /etc/fstab and comment line: “/SOME/DIR/fedora-home /home (...)”"
echo "hidrogeno:/home /home	nfs	tcp,rw,noauto,nolock,ro,users,bg,retry=1        0 0" >> /etc/fstab
echo "hidrogeno:/share /share	nfs	tcp,rw,noauto,nolock,ro,users,bg,retry=1        0 0" >> /etc/fstab


dnf install autofs
#vi /etc/auto.master: (add to the end)
echo "/-    /etc/auto.mount" >> /etc/auto.master
#vim /etc/auto.mount (create and modify new file):
echo "/home -fstype=nfs,rw,tcp  hidrogeno:/home" > /etc/auto.mount
echo "/share -fstype=nfs,rw,tcp  hidrogeno:/share" >> /etc/auto.mount
systemctl start autofs 
systemctl enable autofs 
echo "Finished, now REBOOT"

