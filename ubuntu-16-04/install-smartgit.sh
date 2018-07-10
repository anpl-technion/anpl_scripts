#!/bin/bash

LINK_VER="https://www.syntevo.com/smartgit/changelog.txt"
VER=`curl -s $LINK_VER | grep -E -o -m1 "SmartGit [0-9.]+" | grep -E -o [0-9.]+ | tr . _`
FILE_NAME=smartgit-$VER.dep
LINK="https://www.syntevo.com/downloads/smartgit/smartgit-$VER.deb"
SMARTGIT_OLD_DIR=/opt/ANPL/smartgit

#install java
install-java-jdk.sh

#remove smartgit
sudo apt-get remove smartgit -y

if [ -d "$SMARTGIT_OLD_DIR" ]; then
  cd $SMARTGIT_OLD_DIR
  sudo sh remove-menuitem.sh
  sudo rm -rf $SMARTGIT_OLD_DIR
fi

# install smartgit
cd ~/Downloads
wget -O $FILE_NAME $LINK
sudo dpkg -i $FILE_NAME
rm -f ~/Downloads/$FILE_NAME
