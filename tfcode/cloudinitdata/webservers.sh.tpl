#!/bin/bash
touch /tmp/started
yum -y install httpd
#Start the service
systemctl enable httpd.service
systemctl start httpd.service
#Make changes to firewalld
# firewall-offline-cmd --add-service=http
# firewall-offline-cmd --add-service=ssh
systemctl enable firewalld
systemctl restart firewalld
firewall-cmd --zone=public --add-service=http
firewall-cmd --zone=public --add-service=ssh
firewall-cmd --reload
#Update index.html
hostname > /var/www/html/index.html
touch /tmp/completed