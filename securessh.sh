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

command_mikrotik="command $random_number"
command_cisco="command $random_number"
command_hpe="command $random_number"



if [ $device == 1 ]; then 
	python3 securessh.py $command $host $command_mikrotik 
elif [ $device == 2 ]; then
	python3 securessh.py $command $host $command_cisco
elif [ $device == 3 ]; then
	python3 securessh.py $command $host $command_hpe
fi


