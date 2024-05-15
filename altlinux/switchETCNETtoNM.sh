#!/bin/bash

apt-get install NetworkManager NetworkManager-tui -y

cp /etc/NetworkManager/NetworkManager.conf{,2}
sed -e 's/etcnet-alt//g' /etc/NetworkManager/NetworkManager.conf2 > /etc/NetworkManager/NetworkManager.conf
rm /etc/NetworkManager/NetworkManager.conf2
rm -rf /etc/net/ifaces/ens33
systemctl --now disable network.service

reboot
