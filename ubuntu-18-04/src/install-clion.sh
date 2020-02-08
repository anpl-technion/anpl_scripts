#!/bin/bash

ANPL_OPT=/opt/ANPL
CLION_VER=2018.2.4
CLION_DIR=$ANPL_OPT/clion
LINK=https://download-cf.jetbrains.com/cpp/CLion-$CLION_VER.tar.gz




#remove old clion
sudo rm -rf $CLION_DIR

#download clion file.
sudo mkdir -p $ANPL_OPT
cd ~/Downloads
wget -O clion.tar.gz $LINK
tar -xvzf clion.tar.gz
mv clion-$CLION_VER clion
sudo mv clion $ANPL_OPT
rm -rf clion.tar.gz
/opt/ANPL/clion/bin/clion.sh

cd ~/Downloads
cat << EOF > jetbrains-clion.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=CLion
Icon=/opt/ANPL/clion/bin/clion.svg
Exec=bash -i -c "/opt/ANPL/clion/bin/clion.sh" %f
Comment=The Drive to Develop
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-clion
EOF

sudo mv jetbrains-clion.desktop /usr/share/applications
