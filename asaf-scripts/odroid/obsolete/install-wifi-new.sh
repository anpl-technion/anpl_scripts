sudo service wicd stop

sudo cat << EOF > /etc/wicd/encryption/templates/anpl
name = ANPL
author = Tal Regev
version = 1
require apsk *Preshared_Key
protected apsk *Preshared_Key
-----
ctrl_interface=/var/run/wpa_supplicant
network={
        ssid="$_ESSID"
        psk="$_APSK"
}

EOF

echo "anpl" >> /etc/wicd/encryption/templates/active

sudo service wicd start

