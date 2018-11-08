#!/bin/bash


dnf install -y openssh-server

systemctl start sshd.service

systemctl enable sshd.service

return 0


