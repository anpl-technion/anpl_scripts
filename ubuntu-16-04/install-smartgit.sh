#!/bin/bash

VER='18_1_3'
FILE_NAME=smartgit-$VER.dep
LINK="https://www.syntevo.com/downloads/smartgit/smartgit-$VER.deb"

#install java
install-java-jdk.sh

# download file to Download folder

cd ~/Downloads
wget -O $FILE_NAME $LINK
sudo apt install $FILE_NAME
rm -f ~/Downloads/$FILE_NAME
