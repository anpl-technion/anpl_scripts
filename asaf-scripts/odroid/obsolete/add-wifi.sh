#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Please add wifi connection as follow:"
    echo "add-wifi.sh NETWORKNAME PASSWORD"
    echo "Example: 'add-wifi.sh ANPL anpl1234'"
else

cat << EOF >> /etc/wpa_supplicant.conf
network={
        ssid="$1"
        psk="$2"
}

EOF

fi

