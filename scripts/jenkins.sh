#!/bin/bash

## Add the Jenkins 
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

## Install Jenkins
sudo apt update && apt install -y jenkins

## Start on boot
sudo systemctl enable jenkins && sudo systemctl start jenkins

# Catch the admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword