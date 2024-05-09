#!/bin/bash

read -p $'DHCP - y\n------------\nStatic IP - n\nВыбор: ' user_choice
read -p "Введите имя интерфейса: " interface_name

if [[ $user_choice == 'n' ]]; then
  read -p "Введите IP-адрес (адрес/маска): " ip_address
  read -p "Введите шлюз по умолчанию: " ip_gateway
  echo -e $ip_address > /etc/net/ifaces/$interface_name/ipv4address
  echo default via $ip_gateway > /etc/net/ifaces/$interface_name/ipv4route
  echo -e 'nameserver 8.8.8.8\nnameserver 8.8.4.4' > /etc/net/ifaces/$interface_name/resolv.conf
  echo -e 'BOOTPROTO=static \nTYPE=eth \nNM_CONTROLLED=yes \nDISABLED=no \nCONFIG_WIRELESS=no \nSYSTEMD_BOOTPROTO=static \nCONFIG_IPV4=yes \nSYSTEMD_CONTROLLED=no' > /etc/net/ifaces/$interface_name/options

elif [[ $user_choice == 'y' ]]; then
  cat /dev/null > /etc/net/ifaces/$interface_name/ipv4route
  cat /dev/null > /etc/net/ifaces/$interface_name/ipv4address
  echo -e 'BOOTPROTO=dhcp \nTYPE=eth \nNM_CONTROLLED=yes \nDISABLED=no \nCONFIG_WIRELESS=no \nSYSTEMD_BOOTPROTO=dhcp4 \nCONFIG_IPV4=yes \nSYSTEMD_CONTROLLED=no' > /etc/net/ifaces/$interface_name/options
fi
