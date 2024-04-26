#!/bin/bash

# Установка веб-интерфейса для просмотра логов
dnf install httpd php -y
systemctl restart httpd
systemctl enable httpd
firewall-cmd --add-port=80/tcp --permanent
firewall-cmd --add-port=443/tcp --permanent
firewall-cmd --add-port=10514/tcp --permanent
firewall-cmd --add-port=10514/udp --permanent
firewall-cmd --reload
sudo dnf install mariadb-server rsyslog-mysql php-mysqlnd -y
systemctl restart mariadb
mysql_secure_installation
# $password, n, n, n, n, y, y
systemctl restart mariadb
systemctl enable mariadb
mysql -u root -p < /usr/share/doc/rsyslog/mysql-createDB.sql

mysql -u root -p <<EOF
GRANT ALL ON Syslog.* TO 'rsyslog'@'localhost' IDENTIFIED BY 'kk';
FLUSH PRIVILEGES;
EOF

# Настройка rsyslog
cat /dev/null > /etc/rsyslog.conf
echo '
global(workDirectory="/var/lib/rsyslog")
module(load="builtin:omfile" Template="RSYSLOG_TraditionalFileFormat")
module(load="imuxsock"    # provides support for local system logging (e.g. via logger command)
       SysSock.Use="off") # Turn off message reception via local log socket;
                          # local messages are retrieved through imjournal now.
module(load="imjournal"             # provides access to the systemd journal
       UsePid="system" # PID nummber is retrieved as the ID of the process the journal entry originates from
       StateFile="imjournal.state") # File to store the position in the journal
include(file="/etc/rsyslog.d/*.conf" mode="optional")

*.info;mail.none;authpriv.none;cron.none                /var/log/messages
authpriv.*                                              /var/log/secure
mail.*                                                  -/var/log/maillog
cron.*                                                  /var/log/cron
*.emerg                                                 :omusrmsg:*
uucp,news.crit                                          /var/log/spooler
local7.*                                                /var/log/boot.log

module(load="ommysql")
#*.* :ommysql:127.0.0.1,Syslog_Database,syslog_user,password
*.* :ommysql:127.0.0.1,Syslog,rsyslog,kk

$ModLoad imtcp
$InputTCPServerRun 10514

$ModLoad imudp
$UDPServerRun 10514

$template RemoteLogs,"/var/log/%HOSTNAME%/%PROGRAMNAME%.log"
*.* ?RemoteLogs ' >> /etc/rsyslog.conf


sudo systemctl restart rsyslog


# Установка и настройка loganalyzer --работает 
wget https://download.adiscon.com/loganalyzer/loganalyzer-4.1.13.tar.gz -P /tmp
tar -xzvf /tmp/loganalyzer-4.1.13.tar.gz -C /tmp
mkdir /var/www/html/loganalyzer
cp -r /tmp/loganalyzer-4.1.13/src/* /var/www/html/loganalyzer
cp /tmp/loganalyzer-4.1.13/contrib/configure.sh /var/www/html/loganalyzer
cd /var/www/html/loganalyzer
bash configure.sh
chcon -h -t httpd_sys_script_rw_t config.php


echo "Шаги по установке веб-панели смотрите здесь: https://habr.com/ru/articles/213519/"
