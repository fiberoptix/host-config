#!/usr/bin/env bash

# Get the install scripts
git clone https://github.com/fiberoptix/host-config

# Update Apt
sudo apt-get update

#Install java 8
yes | sudo apt install openjdk-8-jdk

# Install newest Java 10 - Jenkins incompatible with this-- needs 8 above
# yes | sudo apt-get install default-jdk

# create ssh files and directories
cd ~
mkdir .ssh
sleep 3
chmod 700 .ssh

touch .ssh/authorized_keys
chmod 600 .ssh/authorized_keys

# create ssh keys for trusted connect  don't add a pass phrase or it will prompt
mkdir .ssh
sudo ssh-keygen -f .ssh/id_rsa -t rsa -N ''


#setup a file or variable for target hosts that will get a public.key
#touch ~/rsa_hosts.txt
#for ip in `cat ~/rsa_hosts.txt`; do

# copy the publickeyt o the remote host
#    yes yes | sudo ssh-copy-id -i ~/.ssh/id_rsa.pub ubuntu@$ip

# test access - should conenct without a password
# ssh -i ~/.ssh/mykey user@host
#done