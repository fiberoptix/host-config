#!/usr/bin/env bash

#How to install TeamCity on Linux...
# https://confluence.jetbrains.com/display/TCD18/Installing+and+Configuring+the+TeamCity+Server#InstallingandConfiguringtheTeamCityServer-installingWithTomcat

#connect to aws instance
# ssh -i "/Users/agamache/Dropbox/AWS/AG-KEYPAIR-2019.pem" ubuntu@ec2-3-89-137-112.compute-1.amazonaws.com

#remember to add incoming access for port 8111

#----------------------------- Configure the Host
# Change root password
yes 'Powerme!1' | sudo passwd root

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

# Add Java Paths
sudo -u root chmod 777 /etc/environment
sudo echo JAVA_HOME=/usr/lib/jvm/java-8-oracle >> /etc/environment
sudo echo JRE_HOME=/usr/lib/jvm/java-8-oracle/jre >> /etc/environment
#sudo -u root chmod 755 /etc/environment

# install unzip
sudo apt install unzip

#----------------------------- Download and Install

cd ~; mkdir app; chmod -R 775 app
cd app
wget https://download.jetbrains.com/teamcity/TeamCity-2018.2.3.tar.gz
tar -xvf TeamCity-*

#create Teamcity Data dir
mkdir /home/ubuntu/app/TeamCity/data
chmod -R 775 /home/ubuntu/app/TeamCity/data

#------------------------------ Startup and Checkout
#Start TeamCity
/home/ubuntu/app/TeamCity/bin/runAll.sh start

#Tail TC Server Log
# tail -f /home/ubuntu/app/TeamCity/logs/teamcity-server.log

# check TeamCity is running
ps -ef | grep TeamCity

# Check to see port 8111 is open
sudo netstat -tulpn | grep LISTEN

# Add cronjob
echo '@reboot /home/ubuntu/app/TeamCity/bin/runAll.sh start' > ~/crontab
crontab crontab
crontab -l