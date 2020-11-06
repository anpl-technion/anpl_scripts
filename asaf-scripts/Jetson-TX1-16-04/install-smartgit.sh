#!/bin/bash

LINK=https://rpmfind.net/linux/fedora/linux/updates/28/Everything/aarch64/Packages/e/eclipse-swt-4.7.3a-5.fc28.aarch64.rpm
FILE_NAME=swt.rpm

sudo add-apt-repository ppa:eugenesan/ppa
sudo apt-get update

sudo apt-get install smartgit -y


cd ~/Downloads
wget -O $LINK
file-roller -h $FILE_NAME
sudo cp usr/lib/java/swt.jar /usr/share/smartgit/lib/org.eclipse.swt.gtk.linux.x86_64.jar
rm -rf usr $FILE_NAME 
