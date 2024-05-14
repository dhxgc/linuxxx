!#/bin/bash

apt-get install task-samba-dc -y
apt-get update
apt-get install task-samba-dc -y

read -p $'Введите имя ПК (e.g: dc.alt.com): ' dmhostname
hostnamectl hostname $dmhostname

rm -f /etc/samba/smb.conf
rm -rf /var/lib/samba
rm -rf /var/cache/samba
mkdir -p /var/lib/samba/sysvol

samba-tool domain provision
systemctl --now enable samba.service

cp /var/lib/samba/private/krb5.conf /etc/krb5.conf
echo -e "Нажмите любую клавишу для перезагрузки (или Ctrl+C)"
read -n1 ans1
reboot
