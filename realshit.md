Чтобы настроить программный RAID 1, 0 или 10 на Debian 12.5 с использованием утилиты `mdadm`, следуйте этим шагам для каждой конфигурации:

### Установка `mdadm`
Сначала вам нужно установить `mdadm`, если он еще не установлен. Выполните следующие команды в терминале:
```bash
sudo apt update
sudo apt install mdadm
```

### RAID 1 (Зеркалирование)
1. **Подготовьте диски**: Убедитесь, что у вас есть минимум два диска или раздела.
2. **Создайте RAID 1**:
   ```bash
   sudo mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdX1 /dev/sdY1
   ```
   Замените `/dev/sdX1` и `/dev/sdY1` на ваши устройства.
3. **Форматируйте массив**:
   ```bash
   sudo mkfs.ext4 /dev/md0
   ```
4. **Смонтируйте массив**:
   ```bash
   sudo mkdir /mnt/raid1
   sudo mount /dev/md0 /mnt/raid1
   ```

### RAID 0 (Черепашка)
1. **Подготовьте диски**: Вам понадобятся минимум два диска.
2. **Создайте RAID 0**:
   ```bash
   sudo mdadm --create --verbose /dev/md0 --level=0 --raid-devices=2 /dev/sdX1 /dev/sdY1
   ```
3. **Форматируйте массив**:
   ```bash
   sudo mkfs.ext4 /dev/md0
   ```
4. **Смонтируйте массив**:
   ```bash
   sudo mkdir /mnt/raid0
   sudo mount /dev/md0 /mnt/raid0
   ```

### RAID 10 (Комбинированный)
1. **Подготовьте диски**: Нужны минимум четыре диска.
2. **Создайте RAID 10**:
   ```bash
   sudo mdadm --create --verbose /dev/md0 --level=10 --raid-devices=4 /dev/sdX1 /dev/sdY1 /dev/sdZ1 /dev/sdW1
   ```
3. **Форматируйте массив**:
   ```bash
   sudo mkfs.ext4 /dev/md0
   ```
4. **Смонтируйте массив**:
   ```bash
   sudo mkdir /mnt/raid10
   sudo mount /dev/md0 /mnt/raid10
   ```

### Настройка автоматического монтирования и сохранение конфигурации
Добавьте запись в файл `/etc/fstab` для автоматического монтирования при перезагрузке:
```bash
echo '/dev/md0 /mnt/raidX ext4 defaults 0 0' | sudo tee -a /etc/fstab
```
Замените `/mnt/raidX` на нужную вам точку монтирования.

Сохраните конфигурацию RAID:
```bash
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
sudo update-initramfs -u
```

### Мониторинг и управление
Чтобы проверить состояние RAID, используйте:
```bash
sudo mdadm --detail /dev/md0
```

Следуя этим шагам, вы сможете успешно настроить программный RAID 1, 0 и 10 на Debian 12.5. Не забудьте делать регулярные резервные копии данных и следить за состоянием массива [[1](https://reintech.io/blog/configuring-software-raid-mdadm-debian-12)][[3](https://reintech.io/blog/setting-up-raid-storage-on-debian-12)][[4](https://wiki.debian.org/SoftwareRAID)]. 
