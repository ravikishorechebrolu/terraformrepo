#!/bin/bash
touch /tmp/started
sudo yum -y install httpd
#Start the service
sudo systemctl enable httpd.service
sudo systemctl start httpd.service
# Update index.html
sudo chown -R opc:opc /var/www/html
sudo hostname > /var/www/html/index.html
#Make changes to firewalld
firewall-offline-cmd --add-service=http
firewall-offline-cmd --add-service=ssh
sudo systemctl start firewalld
sudo systemctl enable firewalld
# sudo firewall-cmd --permanent --zone=public --add-service=http
# sudo firewall-cmd --permanent --zone=public --add-service=ssh
sudo firewall-cmd --reload
sleep 5
touch /tmp/completed