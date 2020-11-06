#!/bin/bash

ANPL_OPT=/opt/ANPL
CURA_VER=2.0.2
CURA_DIR=$ANPL_OPT/cura
LINK=https://github.com/BCN3D/Cura/releases/download/v$CURA_VER/BCN3D.Cura-$CURA_VER.AppImage
LINK_ICON=https://github.com/BCN3D/Cura/raw/master/icons/cura-512.png


#remove old cura
sudo rm -rf $CURA_DIR

#download cura file.
cd ~/Downloads
wget -O BCN3D.Cura.AppImage $LINK
wget -O cura-512.png $LINK_ICON
chmod +x BCN3D.Cura.AppImage
sudo mkdir -p $CURA_DIR
sudo mv BCN3D.Cura.AppImage cura-512.png $CURA_DIR


cd ~/Downloads
cat << EOF > BCN3D.Cura.desktop
[Desktop Entry]
Version=$CURA_VER
Type=Application
Name=BCN3D Cura
Icon=$CURA_DIR/cura-512.png
Exec=bash -i -c "$CURA_DIR/BCN3D.Cura.AppImage" %f
Comment=Slicer 3D printer
Categories=Slicer;
Terminal=false
StartupWMClass=BCN3D-Cura
EOF

sudo mv BCN3D.Cura.desktop /usr/share/applications
