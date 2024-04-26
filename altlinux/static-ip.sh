#!/bin/bash

read -p "Введите IP-адрес (адрес/маска): " ip_address
read -p "Введите шлюз по умолчанию: " ip_gateway
read -p "Введите имя интерфейса (ip a): " interface_name

echo -e $ip_address > /etc/net/ifaces/$interface_name/ipv4address
echo default via $ip_gateway > /etc/net/ifaces/$interface_name/ipv4route

echo '
BOOTPROTO=static
TYPE=eth
NM_CONTROLLED=yes
DISABLED=yes
CONFIG_WIRELESS=no
SYSTEMD_BOOTPROTO=static
CONFIG_IPV4=yes
SYSTEMD_CONTROLLED=no' >> /etc/net/ifaces/$interface_name/options
