#!/usr/bin/env bash

#v 2.0

#----------- IMPORTANT!!! ------------
# NEED to run this script as ansible user on MASTER

# Prep and install Ansible
pip3 install ansible --user

#Check out python and ansible
sudo yum list installed | grep python
ansible --version

# create ssh keys for trusted connect  don't add a pass phrase or it will prompt
cd /home/ansible
rm -R .ssh
mkdir .ssh
sleep 1
chmod 700 .ssh

touch .ssh/authorized_keys
chmod 644 .ssh/authorized_keys

sudo ssh-keygen -f .ssh/id_rsa -t rsa -N ''

sudo chmod 644 /home/ansible/.ssh/id_rsa.pub
sudo chmod 600 /home/ansible/.ssh/id_rsa

sudo chown -R ansible:ansible /home/ansible/.ssh

#Exchange RSA keys from Master to Nodes
# You're going to have to type in the password for all of these
for host in 172.31.58.61 172.31.48.204 172.31.60.203; do
ssh-copy-id -i /home/ansible/.ssh/id_rsa.pub $host;
done

