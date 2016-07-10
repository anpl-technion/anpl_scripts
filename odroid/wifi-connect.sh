#!/bin/bash

service network-manager stop
rm -rf /var/run/wpa_supplicant
#mkdir -p /var/run/wpa_supplicant
ifconfig wlan0 down
#connect wifi from here: 
#http://askubuntu.com/questions/138472/how-do-i-connect-to-a-wpa-wifi-network-using-the-command-line
wpa_supplicant -B -iwlan0 -c/etc/wpa_supplicant.conf -Dwext && dhclient wlan0

