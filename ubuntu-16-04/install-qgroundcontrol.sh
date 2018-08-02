#!/bin/bash

ANPL_OPT=/opt/ANPL
QG_VER=3.3.2
QG_DIR=$ANPL_OPT/qgroundcontrol
LINK=https://github.com/mavlink/qgroundcontrol/releases/download/v$QG_VER/QGroundControl.AppImage
LINK_ICON=https://github.com/mavlink/qgroundcontrol/raw/master/resources/icons/android_512x512.png


#remove old cura
sudo rm -rf $QG_DIR

#download cura file.
cd ~/Downloads
wget -O QGroundControl.AppImagee $LINK
wget -O QGroundControl_512x512.png $LINK_ICON
chmod +x QGroundControl.AppImagee
sudo mkdir -p $QG_DIR
sudo mv QGroundControl.AppImagee QGroundControl_512x512.png $CURA_DIR


cd ~/Downloads
cat << EOF > QGroundControl.desktop
[Desktop Entry]
Version=$CURA_VER
Type=Application
Name=QGroundControl
Icon=$QG_DIR/QGroundControl_512x512.png
Exec=bash -i -c "$QG_DIR/QGroundControl.AppImagee" %f
Comment=Ground Control Station
Categories=GCS;
Terminal=false
StartupWMClass=QGroundControl
EOF

sudo mv QGroundControl.desktop /usr/share/applications
