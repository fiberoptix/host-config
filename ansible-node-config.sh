#!/usr/bin/env bash

#v 2.0

# Run this script as root on Ansible Nodes

# sudo su - root

#Change the hostname
NODENAME=Ansible-Node-$1
hostnamectl set-hostname $NODENAME

#Or use this and pass it a hostname when you run the script
#hostnamectl set-hostname Ansible-$1

# Add Ansible user on all hosts
#useradd -m -p $pass $username
useradd -m -p passtemp ansible
sleep 1
yes Secret2019 | passwd ansible
yes Secret2019 | passwd ec2-user

# Setup home directory and add aster install script
mkdir /home/ansible
curl https://raw.githubusercontent.com/fiberoptix/host-config/master/ansible-master-install.sh > /home/ansible/ansible-node-install.sh
chown -R ansible:ansible /home/ansible
chmod -R 755 /home/ansible

#Make ansible a sudoer
echo 'ansible        ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers

# Enable SSH connections
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.BAK
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config

# Allow users to ssh connect
echo '#' >> /etc/ssh/sshd_config
echo 'AllowUsers ec2-user root ansible' >> /etc/ssh/sshd_config

#Restart SSH
systemctl restart sshd

# RHEL Install Enterprise extensions
sudo yum install wget -y
cd /etc/yum.repos.d
sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum update --nobest -y

# install Python3 and PIP
sudo yum install python3 -y
sudo yum -y install python3-pip -y
sudo pip3 install --upgrade pip

#Check out python and ansible
sudo yum list installed | grep python
