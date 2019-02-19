#!/usr/bin/env bash

# This package installation will:
# Setup Jenkins as a daemon launched on start. See /etc/init.d/jenkins for more details.
# Create a ‘jenkins’ user to run this service.
# Direct console log output to the file /var/log/jenkins/jenkins.log. Check this file if you are troubleshooting Jenkins.
# Populate /etc/default/jenkins with configuration parameters for the launch, e.g JENKINS_HOME
# Set Jenkins to listen on port 8080. Access this port with your browser to start configuration.

# More Jenkins help: https://jenkins.io/doc/book/installing/#debianubuntu

sudo apt-get update
#yes | sudo apt-get install default-jdk - Java 10 does not work with Jenkins 2, needs 8
yes | sudo apt install openjdk-8-jdk

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
yes | sudo apt-get install jenkins

# AWS Console HOST > Security groups > launch-wizard-1 > Inbound >> add 8080 and 22

echo ""
echo -e "Use a browser to login to Jenkins and install plugins @ >> hostname:8080"
echo ""
echo -e "Your Admin password is..."
echo -e $(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
echo ""
echo -e "cat this file for further instructions"

# Manage Jenkins > Configure Global Security > Agents : JNLP Random

# Manage Nodes > New Node > "slave" & Perm Agent > OK
# Remote Root > /jenkins/workspace

# Setup salve node for jenkins

# create ssh keys for trusted connect
ssh-keygen -f id_rsa -t rsa -N ''
mv ~/id* .ssh/

#setup a file or variable for target hosts that will get a public.key
touch ~/rsa_hosts.txt
for ip in `cat ~/rsa_hosts.txt`; do
    ssh-copy-id -i ~/.ssh/id_rsa.pub $ip
done

