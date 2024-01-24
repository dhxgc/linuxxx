!#/bin/bash

sshpass -p "password" ssh -o StrictHostKeyChecking=no user@ip \
'commands1; commands2;'
