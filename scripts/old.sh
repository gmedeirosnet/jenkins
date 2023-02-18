#!/bin/bash

## Add the Jenkins 
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

## Install Jenkins
apt update && apt install -y jenkins

## Start on boot
systemctl enable jenkins && systemctl start jenkins

# Catch the admin password
cat /var/lib/jenkins/secrets/initialAdminPassword