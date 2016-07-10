#!/bin/bash

RAPID_VER="0.9u4"

install-java-jdk.sh

# download file to Download folder
rm -rf ~/FreeRapid-*
cd ~/Downloads
wget -O FreeRapid.zip "http://garr.dl.sourceforge.net/project/manualinux/FreeRapid/FreeRapid-$RAPID_VER.zip"
unzip FreeRapid.zip -d $HOME
rm FreeRapid.zip
cd ~/FreeRapid-$RAPID_VER
chmod +x frd.sh
cat << EOF > freerapid.desktop
[Desktop Entry]
Name=Free Rapid
Type=Application
Exec=$HOME/FreeRapid-$RAPID_VER/frd.sh
Terminal=false
Icon=$HOME/FreeRapid-$RAPID_VER/frd.ico
Comment=FreeRapid Downloader
NoDisplay=false
Categories=Downloader;
Name[en]=Free Rapid

EOF
sudo mv freerapid.desktop /usr/share/applications/
