#!/bin/bash

VER='17'
PROGRAMS=/opt/ANPL
WORKING_PATH=$PROGRAMS/smartgit/
FILE_NAME=smartgit-linux-$VER.tar.gz
LINK="http://www.syntevo.com/static/smart/download/smartgit/smartgit-linux-$VER.tar.gz"

#install java
install-java-jdk.sh

# download file to Download folder
rm -rf $WORKING_PATH
cd ~/Downloads
wget -O $FILE_NAME $LINK
sudo mkdir -p $PROGRAMS
sudo tar zxf $FILE_NAME -C $PROGRAMS
cd $WORKING_PATH/bin
./remove-menuitem.sh
./add-menuitem.sh

rm -f ~/Downloads/$FILE_NAME
