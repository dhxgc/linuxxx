#!/bin/bash

# Проверка наличия пакетов
if ! dpkg -l | grep -qw samba; then
    echo "Пакет samba не установлен. Установка..."
    apt update
    apt install -y samba
else
    echo "Пакет samba уже установлен."
fi

if ! dpkg -l | grep -qw smbclient; then
    echo "Пакет smbclient не установлен. Установка..."
    apt install -y smbclient
else
    echo "Пакет smbclient уже установлен."
fi

# Запрашиваем у пользователя путь до папки
read -p "Введите путь до папки: " folder_path

# Проверка существования папки
if [ ! -d "$folder_path" ]; then
    echo "Указанная папка не существует. Пожалуйста, проверьте путь."
    exit 1
fi

# Установка рекурсивных прав 777
chmod -R 777 "$folder_path"
echo "Права 777 установлены на папку: $folder_path"

# Запрашиваем у пользователя имя секции
read -p "Введите имя секции для конфигурации Samba: " section_name

# Форматируем запись конфигурации
conf_entry="[$section_name]
path = $folder_path
browseable = yes
read only = no
public = yes"

# Проверка, существует ли секция
if grep -q "^$$$section_name$$" /etc/samba/smb.conf; then
    echo "Секция [$section_name] уже существует в smb.conf."
else
    echo -e "$conf_entry" >> /etc/samba/smb.conf
    echo "Конфигурация Samba добавлена в smb.conf."
fi

echo "Настройка завершена."
