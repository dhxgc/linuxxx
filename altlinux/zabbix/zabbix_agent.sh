#!/bin/bash

read -p "Введите IP-адрес Zabbix-сервера: " server_ip
read -p "Введите номер клиента Zabbix: " num_client

echo '
LogFile=/var/log/zabbix/zabbix_agentd.log
Server='$server_ip'
ServerActive='$server_ip'
Hostname='$num_client'_client' > /etc/zabbix/zabbix_agentd.conf

systemctl --now enable zabbix_agentd
