#!/bin/bash

sudo apt install apache2
sudo apt install git
#install the Web Server and another tools

maindir="/etc/apache2/sites-available/"
webdir="/var/www/"
#cp "$maindir/000-default.conf" "$maindir/backup.conf"
#backup our main config

echo how many hosts you wanna create?
read iter_host

for ((i = 0; i < $iter_host; i++))
do
    
  echo -e "enter name of host (without domain (f.e . com, .ru etc)): "
  read hostname
  echo -e "enter domain: "
  read domain

  webdir_domain="$webdir$hostname"
  conffile="$maindir$hostname.conf"

  mkdir "$webdir_domain"
  touch "$conffile"
  touch "$webdir_domain/index.html"
  echo -e "<!DOCTYPE html>
  <html lang="ru">
    <head>
      <meta charset=UTF-8>
      <meta http-equiv=Content-type content=text/html; charset=utf-8>
      <link rel=stylesheet href=src/style/style.css>
      <title>not trust please</title>
    </head>
    <body>
      <h1>THIS IS $conffile$domain!!!</h1>
    </body>
  </html>"\
     >> "$webdir_domain/index.html"

  echo -e \
   "<VirtualHost *:80>
    ServerName $hostname$domain
    ServerAlias www.$hostname$domain
    ServerAdmin webmaster@$hostname$domain
    DocumentRoot $webdir_domain/

    <Directory $webdir_domain/>
        Options -Indexes +FollowSymLinks
        AllowOverride All
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/example.com-error.log
    CustomLog \${APACHE_LOG_DIR}/example.com-access.log combined
</VirtualHost>"\
   >> "$conffile"

  echo "enter your IP address:"
  read ipad
  echo "$ipad   $hostname$domain" >> /etc/hosts
#  read
#  sudo a2ensite "$conffile.conf" ??????????????????

  echo "please, put your files for web-site in $webdir_domain and press Enter..."
  echo "you needa to activate .conf files with: \'sudo a2ensite example.conf\' and reload the apache with systemctl"
  read
done
