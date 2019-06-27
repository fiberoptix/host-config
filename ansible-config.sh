#!/usr/bin/env bash


#----------- IMPORTANT!!! ------------
# NEED to run this script as ansible user on MASTER


# create ssh keys for trusted connect  don't add a pass phrase or it will prompt
cd ~
mkdir .ssh
sleep 3
chmod 700 .ssh

touch .ssh/authorized_keys
chmod 600 .ssh/authorized_keys
sudo ssh-keygen -f .ssh/id_rsa -t rsa -N ''

#Exchange RSA keys from Master to Nodes
# You're going to have to type in the password for all of these
for host in 172.31.60.98 172.31.60.232 172.31.60.179; do
ssh-copy-id $host;
done

# Prep and install Ansible
pip3 install ansible --user

#Check out python and ansible
sudo yum list installed | grep python
ansible --version