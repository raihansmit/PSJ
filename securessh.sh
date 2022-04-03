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

command_mikrotik=$(echo "
ip service set ssh port=$random_number
/ip firewall filter
add action=add-src-to-address-list address-list=port_scanners \
    address-list-timeout=2w chain=input comment=\
    "Add TCP Port Scanners to List" protocol=tcp psd=21,3s,3,1

add action=add-src-to-address-list address-list=port_scanners \
    address-list-timeout=2w chain=input comment="TCP FIN Stealth scan" \
    protocol=tcp tcp-flags=fin,!syn,!rst,!psh,!ack,!urg

add action=add-src-to-address-list address-list=port_scanners \
    address-list-timeout=2w chain=input comment="TCP SYN/FIN scan" protocol=\
    tcp tcp-flags=fin,syn

add action=add-src-to-address-list address-list=port_scanners \
    address-list-timeout=2w chain=input comment="TCP SYN/RST scan" protocol=\
    tcp tcp-flags=syn,rst

add action=add-src-to-address-list address-list=port_scanners \
    address-list-timeout=2w chain=input comment="TCP FIN/PSH/URG scan" \
    protocol=tcp tcp-flags=fin,psh,urg,!syn,!rst,!ack

add action=add-src-to-address-list address-list=port_scanners \
    address-list-timeout=2w chain=input comment="ALL/ALL TCP Scan" protocol=\
    tcp tcp-flags=fin,syn,rst,psh,ack,urg

add action=add-src-to-address-list address-list=port_scanners \
    address-list-timeout=2w chain=input comment="TCP NULL scan" protocol=tcp \
    tcp-flags=!fin,!syn,!rst,!psh,!ack,!urg

add action=drop chain=input comment="Drop All Port Scanners" \
    src-address-list=port_scanners
" > file_mikrotik.txt)
file_mikrotik="file_mikrotik.txt"
command_cisco="command $random_number > file_cisco.txt"
file_cisco="file_cisco.txt"
command_hpe="command $random_number"
file_hpe="file_hpe.txt"

if [ $device == 1 ]; then 
	python3 sshremote.py $command $host $file_mikrotik $random_number
elif [ $device == 2 ]; then
	python3 sshremote.py $command $host $file_cisco $random_number
elif [ $device == 3 ]; then
 	python3 sshremote.py $command $host $file_hpe $random_number
fi

rm $(pwd)/file_mikrotik.txt
rm $(pwd)/file_cisco.txt
rm $(pwd)/file_hpe.txt