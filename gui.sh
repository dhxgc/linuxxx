!#/bin/bash

echo -e "Start CLI or GUI? [c/g]: "
read yn

if [ $yn = 'c' ]
then
	sudo systemctl enable multi-user.target
	sudo systemctl set-default multi-user.target
	sudo reboot
elif [ $yn = 'g' ]
then
	sudo systemctl enable graphical.target
	sudo systemctl set-default graphical.target
	sudo reboot
else
	echo -e "Unknown operation!"
fi
