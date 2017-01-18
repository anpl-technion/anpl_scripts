#!/bin/bash

#from https://www.digitalocean.com/community/tutorials/how-to-setup-vnc-for-ubuntu-12

apt-get install ubuntu-desktop tightvncserver xfce4 xfce4-goodies -y

mkdir -p ~/.vnc
cd ~/
cat << EOF > .vnc/xstartup
#!/bin/sh
xrdb $HOME/.Xresources
xsetroot -solid grey
startxfce4 &

EOF

chmod +x .vnc/xstartup
