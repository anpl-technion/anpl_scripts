#!/bin/bash


sudo apt-get install wpasupplicant -y
rm -rf /etc/wpa_supplicant.conf
cat << EOF > /etc/wpa_supplicant.conf
network={
        ssid="ANPL"
        psk="anpl1234"
}

EOF
