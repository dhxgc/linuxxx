!#/bin/bash

apt-get install task-samba-dc
apt-get update
apt-get install task-samba-dc

read -p $'Введите имя ПК (e.g: dc.alt.com): ' dmhostname
hostnamectl hostname $dmhostname

rm -f /etc/samba/smb.conf
rm -rf /var/lib/samba
rm -rf /var/cache/samba
mkdir -p /var/lib/samba/sysvol

samba-tool domain 
