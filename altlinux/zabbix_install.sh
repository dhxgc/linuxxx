#!/bin/bash

apt-get update -y

apt-get install postgresql13-server zabbix-server-pgsql fping -y
/etc/init.d/postgresql initdb
systemctl enable --now postgresql

su - postgres -s /bin/sh -c 'createuser --no-superuser --no-createdb --no-createrole --encrypted --pwprompt zabbix'
su - postgres -s /bin/sh -c 'createdb -O zabbix zabbix'

su - postgres -s /bin/sh -c 'psql -U zabbix -f /usr/share/doc/zabbix-common-database-pgsql-*/schema.sql zabbix'
su - postgres -s /bin/sh -c 'psql -U zabbix -f /usr/share/doc/zabbix-common-database-pgsql-*/images.sql zabbix'
su - postgres -s /bin/sh -c 'psql -U zabbix -f /usr/share/doc/zabbix-common-database-pgsql-*/data.sql zabbix'

apt-get install apache2 apache2-mod_php8.1 -y
systemctl enable --now httpd2
apt-get install php8.1 php8.1-mbstring php8.1-sockets php8.1-gd php8.1-xmlreader php8.1-pgsql php8.1-ldap php8.1-openssl -y

#здесь приколы с /etc/php/8.1/apache2-mod_php/php.ini
#делаем бекап ориг файлика, затем вставляем наши данные
cp /etc/php/8.1/apache2-mod_php/php.ini{,.bkp}
echo '[PHP]
engine = On
short_open_tag = On
asp_tags = Off
precision = 14
output_buffering = 4096
zlib.output_compression = Off
implicit_flush = Off
unserialize_callback_func =
serialize_precision = 100
disable_functions =
disable_classes =
zend.enable_gc = On
expose_php = On
max_execution_time = 600
max_input_time = 600
memory_limit = 256M
error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT
display_errors = Off
display_startup_errors = Off
log_errors = On
log_errors_max_len = 1024
ignore_repeated_errors = Off
ignore_repeated_source = Off
report_memleaks = On
track_errors = Off
html_errors = On
variables_order = "GPCS"
request_order = "GP"
register_argc_argv = Off
auto_globals_jit = On
post_max_size = 32M
auto_prepend_file =
auto_append_file =
default_mimetype = "text/html"
default_charset = "UTF-8"
include_path = "./:/usr/share/php/pear/:/usr/share/php/modules/"
user_dir =
enable_dl = Off
file_uploads = On
upload_tmp_dir = /tmp
upload_max_filesize = 20M
max_file_uploads = 20
allow_url_fopen = On
allow_url_include = Off
default_socket_timeout = 60
[CLI Server]
cli_server.color = On
[Date]
[filter]
[iconv]
[intl]
[Pcre]
[Phar]
[SQL]
sql.safe_mode = Off
[bcmath]
[browscap]
browscap = "/etc/php/8.1/apache2-mod_php/browscap.ini"
[Session]
session.save_handler = files
session.use_strict_mode = 0
session.use_cookies = 1
session.use_only_cookies = 1
session.name = PHPSESSID
session.auto_start = 0
session.cookie_lifetime = 0
session.cookie_path = /
session.cookie_domain =
session.cookie_httponly =
session.serialize_handler = php
session.gc_probability = 1
session.gc_divisor = 1000
session.gc_maxlifetime = 1440
session.referer_check =
session.cache_limiter = nocache
session.cache_expire = 180
session.use_trans_sid = 0
session.hash_function = 0
session.hash_bits_per_character = 5
url_rewriter.tags = "a=href,area=href,frame=src,input=src,form=fakeentry"
[Assertion]
[COM]
[sysvshm]' >> /etc/php/8.1/apache2-mod_php/php.ini

cp /etc/zabbix/zabbix_server.conf{,.bkp}
echo 'LogFile=/var/log/zabbix/zabbix_server.log
DBHost=localhost
DBName=zabbix
DBUser=zabbix
DBPassword=kk
Timeout=4
LogSlowQueries=3000
StatsAllowedIP=127.0.0.1' >> /etc/zabbix/zabbix_server.conf

systemctl enable --now zabbix_pgsql

apt-get install zabbix-phpfrontend-apache2 zabbix-phpfrontend-php8.1 -y
ln -s /etc/httpd2/conf/addon.d/A.zabbix.conf /etc/httpd2/conf/extra-enabled/
systemctl restart httpd2
chown apache2:apache2 /var/www/webapps/zabbix/ui/conf
