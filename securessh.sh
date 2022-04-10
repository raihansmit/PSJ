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

echo "Username :"
read username

echo "Password :"
read password

random_number=$(od -vAn -N2 -tu2 < /dev/urandom)

command_mikrotik=$(echo "
ip service set ssh port=$random_number"> file_mikrotik.txt)
file_mikrotik="file_mikrotik.txt"
command_cisco="command $random_number > file_cisco.txt"
file_cisco="file_cisco.txt"
command_hpe="command $random_number"
file_hpe="file_hpe.txt"

if [ $device == 1 ]; then 
	python3 sshremote.py $command $host $file_mikrotik $random_number $username $password
elif [ $device == 2 ]; then
	echo 'ON DEVELOPMENT'
elif [ $device == 3 ]; then
 	echo 'ON DEVELOPMENT'
fi

rm $(pwd)/file_mikrotik.txt
rm $(pwd)/file_cisco.txt
rm $(pwd)/file_hpe.txt