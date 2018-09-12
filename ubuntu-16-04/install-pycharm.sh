#!/bin/bash

ANPL_OPT=/opt/ANPL
PYCHARM_VER=2018.2.3
PYCHARM_DIR=$ANPL_OPT/pycharm
LINK=https://download-cf.jetbrains.com/python/pycharm-professional-$PYCHARM_VER.tar.gz




#remove old clion
sudo rm -rf $PYCHARM_DIR

#download clion file.
sudo mkdir -p $ANPL_OPT
cd ~/Downloads
wget -O pycharm.tar.gz $LINK
tar -xvzf pycharm.tar.gz
mv pycharm-$PYCHARM_VER pycharm
sudo mv pycharm $ANPL_OPT
rm -rf pycharm.tar.gz
/opt/ANPL/pycharm/bin/pycharm.sh

cd ~/Downloads
cat << EOF > jetbrains-pycharm.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=Pycharm
Icon=/opt/ANPL/pycharm/bin/pycharm.png
Exec=bash -i -c "/opt/ANPL/pycharm/bin/pycharm.sh" %f
Comment=The Drive to Develop
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-pycharm
EOF

sudo mv jetbrains-pycharm.desktop /usr/share/applications
