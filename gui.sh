#!/bin/bash

echo -e "Start CLI or GUI? [c/g]: "
read yn

if [[ "$yn" = 'c' ]]
then
    systemctl enable multi-user.target
    systemctl set-default multi-user.target
    reboot
elif [[ "$yn" = 'g' ]]
then
    systemctl enable graphical.target
    systemctl set-default graphical.target
    reboot
else
    echo -e "Unknown operation!"
fi
