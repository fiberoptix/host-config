#!/usr/bin/env bash

#connect to aws instance
ssh -i "/Users/agamache/Dropbox/AWS/AG-KEYPAIR-2019.pem" ubuntu@ec2-3-82-63-89.compute-1.amazonaws.com

#----------------------------- Configure the Host
# Change root password
yes Powerme!1 | sudo passwd root

#Change the hostname
sudo hostnamectl set-hostname TeamCity

#install Java 8
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
#make it default
sudo apt-get install oracle-java8-set-default
#confirm it
java -version

#Setup Java Paths
#su root
chmod 755 /etc/environment
#exit

# Add Java Paths
sudo cat >> /etc/environment <<EOL
JAVA_HOME=/usr/lib/jvm/java-8-oracle
JRE_HOME=/usr/lib/jvm/java-8-oracle/jre
EOL

#----------------------------- Download and Install

cd ~; mkdir app; chmod -R 775 app
cd app
wget https://download.jetbrains.com/teamcity/TeamCity-2018.2.3.tar.gz
tar -xvf TeamCity-*

