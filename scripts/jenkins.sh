#!/bin/bash

## Start on boot
sudo systemctl enable jenkins && sudo systemctl start jenkins

# Display the initial password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword