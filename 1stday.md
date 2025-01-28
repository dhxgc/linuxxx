Чего поделать:
 - Поменять сетку на простой бридж
 - Юзеры в идеке, как это ваще работает?...
 - Обратный прокси на идеке
 - DHCP на идеке

1. `/etc/NetworkManager/NetworkManager.conf`, убрать `etcnet`
2. В `/etc/net/ifaces/ens18/options` поставить NM_CONTROLLED=no
3. `systemctl --now disable NetworkManager`
