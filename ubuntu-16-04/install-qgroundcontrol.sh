#!/bin/bash

ANPL_OPT=/opt/ANPL
QGC_VER=3.3.2
QGC_DIR=$ANPL_OPT/qgroundcontrol
LINK=https://s3-us-west-2.amazonaws.com/qgroundcontrol/builds/master/QGroundControl.AppImage
LINK_ICON=https://github.com/mavlink/qgroundcontrol/raw/master/resources/icons/android_512x512.png


#remove old cura
sudo rm -rf $QG_DIR

#download cura file.
cd ~/Downloads
wget -O QGroundControl.AppImagee $LINK
wget -O QGroundControl_512x512.png $LINK_ICON
chmod +x QGroundControl.AppImagee
sudo mkdir -p $QGC_DIR
sudo mv QGroundControl.AppImagee QGroundControl_512x512.png $QGC_DIR


cd ~/Downloads
cat << EOF > QGroundControl.desktop
[Desktop Entry]
Version=$QGC_VER
Type=Application
Name=QGroundControl
Icon=$QGC_DIR/QGroundControl_512x512.png
Exec=bash -i -c "$QGC_DIR/QGroundControl.AppImagee" %f
Comment=Ground Control Station
Categories=GCS;QGC;
Terminal=false
StartupWMClass=QGroundControl
EOF

sudo mv QGroundControl.desktop /usr/share/applications
sudo usermod -a -G dialout $USER
