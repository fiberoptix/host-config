#!/usr/bin/env bash

# Install Docker CE 1

# You can install Docker CE in different ways, depending on your needs:
# Most users set up Docker’s repositories and install from them, for ease of installation and upgrade tasks.
# This is the recommended approach.
# https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository

# Update the apt package index:
sudo apt-get update

# Install packages to allow apt to use a repository over HTTPS:
yes | sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

#Add Docker key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#Add stable rep
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

#Install Docker CE
sudo apt-get update
yes | sudo apt-get install docker-ce docker-ce-cli containerd.io

#Check to see if it's running
sudo docker run hello-world

# Install Selenium on the Docker Host