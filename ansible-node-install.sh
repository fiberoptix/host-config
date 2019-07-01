#!/usr/bin/env bash

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