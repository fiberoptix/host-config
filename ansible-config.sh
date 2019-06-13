#!/usr/bin/env bash

# Drop to root
sudo su - root

# Enable SSH connections
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
systemctl restart sshd.service

# Add Ansible user
#useradd -m -p $pass $username
useradd -m -p ansible ansible

