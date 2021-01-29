#!/bin/bash
touch /tmp/started
sudo yum -y install tomcat
sudo systemctl start tomcat.service
sudo systemctl enable tomcat.service
sudo firewall-offline-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-offline-cmd --zone=public --add-port=1521/tcp --permanent
#sudo firewall-offline-cmd --zone=public --add-port=1522/tcp --permanent
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --reload
