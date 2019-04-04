#!/usr/bin/env bash

#connect to aws instance
#ssh -i "/Users/agamache/Dropbox/AWS/AG-KEYPAIR-2019.pem" ubuntu@ec2-18-212-53-200.compute-1.amazonaws.com

# Get this File and run it
# wget https://raw.githubusercontent.com/fiberoptix/host-config/master/teamcity_agent_install.sh

#----------------------------- Configure the Host
# Change root password
sudo passwd root

#Change the hostname
sudo hostnamectl set-hostname TeamCityAgent1

#install Java 8
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer

#make it default
sudo apt-get install oracle-java8-set-default

#confirm it
#java -version

# Add Java Paths
sudo -u root chmod 777 /etc/environment
sudo echo JAVA_HOME=/usr/lib/jvm/java-8-oracle >> /etc/environment
sudo echo JRE_HOME=/usr/lib/jvm/java-8-oracle/jre >> /etc/environment
#sudo -u root chmod 755 /etc/environment

# install unzip
sudo apt install unzip

#----------------------------- Download and Install
#Create directories
cd ~; mkdir app; chmod -R 775 app
cd app
mkdir TeamCity; chmod -R 775 TeamCity
cd TeamCity
mkdir /home/ubuntu/app/TeamCity/data;
chmod -R 775 /home/ubuntu/app/TeamCity/data

wget http://ec2-3-90-27-112.compute-1.amazonaws.com:8111/update/buildAgent.zip
unzip buildAgent*

cd conf
cp buildAgent.dist.properties buildAgent.properties

echo "Add the TC Server address to the conf/buildAgent.properties file"
echo "Example: http://ec2-3-90-27-112.compute-1.amazonaws.com:8111"

#------------------------------ Startup and Checkout
#Start TeamCity
#/home/ubuntu/app/TeamCity/bin/agent.sh start