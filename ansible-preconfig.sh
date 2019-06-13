#!/usr/bin/env bash

# Run this script as root on all hosts
# sudo su - root

# Change root password
#yes 'newpassword' | sudo passwd root

#Change the hostname
hostnamectl set-hostname Ansible-Master

#Or use this and pass it a hostname when you run the script
#hostnamectl set-hostname Ansible-$1

# Add Ansible user on all hosts
#useradd -m -p $pass $username
useradd -m -p passtemp ansible
sleep 1
yes Secret2019 | passwd ansible

#Make ansible a sudoer
echo 'ansible        ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers

# Enable SSH connections
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config

# Allow users to ssh connect
echo '#' >> /etc/ssh/sshd_config
echo 'AllowUsers root ansible' >> /etc/ssh/sshd_config

#Restart SSH
systemctl restart sshd

#Install Enterprise extensions
yum install wget -y

cd /etc/yum.repos.d
wget https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
rpm -ivh epel-release-7-11.noarch.rpm

yum update --nobest -y
