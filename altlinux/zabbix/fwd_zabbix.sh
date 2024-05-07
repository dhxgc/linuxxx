#!/bin/bash

apt-get install firewalld -y
systemctl --now enable firewalld
firewall-cmd --add-service=zabbix-server --add-service=zabbix-server --permanent
firewall-cmd --reload
