#!/usr/bin/env bash
#
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
# consider using this sshpass solution in the future
# https://serverfault.com/questions/306541/automating-ssh-copy-id
#
# TODO: remember to update this HOST IP file in the repository
wget https://raw.githubusercontent.com/fiberoptix/ansible-dev/master/project.hosts
while read -r host do
ssh-copy-id -i /home/ansible/.ssh/id_rsa.pub $host;
done < project.hosts

#Setup Ansible Config Files
sudo mkdir /etc/ansible
sudo chown -R ansible:ansible /etc/ansible
chmod -R 775 /etc/ansible

cd /etc/ansible/
# TODO: remember to update this file with the default ansible config and pre-commit to repo
wget https://raw.githubusercontent.com/fiberoptix/ansible-dev/master/ansible.cfg

# TODO: remember to update this ANSIBLE HOST file in the repository
wget https://raw.githubusercontent.com/fiberoptix/ansible-dev/master/hosts
