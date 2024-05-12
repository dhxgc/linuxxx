#!/bin/bash

apt-get install NetworkManager NetworkManager-tui

cp /etc/NetworkManager/NetworkManager.conf{,2}
sed -e 's/etcnet-alt//g' /etc/NetworkManager/NetworkManager.conf2 > /etc/NetworkManager/NetworkManager.conf
rm /etc/NetworkManager/NetworkManager.conf2

reboot
