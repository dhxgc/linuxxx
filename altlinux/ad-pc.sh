#!/bin/bash

DEFAULT_VALUE="admin"

echo -e "Кем будет использоваться данный ПК? [admin/user]"
read -p $"Значние по умолчанию: [$DEFAULT_VALUE]: " input
foper=${input:-$DEFAULT_VALUE}

#echo "В случае ошибок при установке "

if [[ $foper == "admin" ]]; then
        apt-get install alterator-auth alterator-gpupdate
        apt-get install admx-basealt admx-yandex-browser admx-chromium admx-firefox admx-msi-setup
        apt-get update
        apt-get install admx-basealt admx-yandex-browser admx-chromium admx-firefox admx-msi-setup
        admx-msi-setup
        apt-get install admc gpui
        echo "Перед вводом в домен предварительно настройте DNS!"
elif [[ $foper == "user" ]]; then
        apt-get install alterator-auth alterator-gpupdate
        echo "Перед вводом в домен предварительно настройте DNS!"
else
        echo "Введите правильное значение!"
        exit 1
fi