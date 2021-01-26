#!/bin/bash
touch /tmp/started
sudo yum -y install httpd
#Start the service
sudo systemctl enable httpd.service
sudo systemctl start httpd.service
#Make changes to firewalld
# firewall-offline-cmd --add-service=http
# firewall-offline-cmd --add-service=ssh
sudo systemctl enable firewalld
sudo systemctl restart firewalld
sleep 10
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=ssh
sudo firewall-cmd --reload
sleep 10
#Update index.html
sudo chown -R opc:opc /var/www/html
sudo hostname > /var/www/html/index.html
touch /tmp/completed