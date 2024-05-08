#!/bin/bash

apt-get install firewalld -y
systemctl --now enable firewalld
firewall-cmd --add-service=zabbix-server --add-service=zabbix-agent --permanent
firewall-cmd --add-service=http --add-service=https --permanent
firewall-cmd --reload
