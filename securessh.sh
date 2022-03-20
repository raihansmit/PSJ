#!/bin/bash

figlet -c securessh	#title


echo "1. Mikrotik"
echo "2. Cisco"
echo "3. HPE"

echo "Choose Your Device : "
read device


echo "Masukan File Command : "
read command

echo "Masukan File Host : "
read host

random_number=$(od -vAn -N2 -tu2 < /dev/urandom)

command_mikrotik=$(echo "ip service edit ssh port$random_number" > file_mikrotik.txt)
file_mikrotik="file_mikrotik.txt"
command_cisco="command $random_number"
command_hpe="command $random_number"



if [ $device == 1 ]; then 
	python sshremote.py $command $host $file_mikrotik 
elif [ $device == 2 ]; then
	python sshremote.py $command $host $command_cisco
elif [ $device == 3 ]; then
	python sshremote.py $command $host $command_hpe
fi


