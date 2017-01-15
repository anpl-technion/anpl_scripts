#!/bin/bash

VER='8_0_4'
PROGRAMS=~/ANPL/programs
WORKING_PATH=$PROGRAMS/smartgit/
FILE_NAME=smartgit-$VER.tar.gz

#install java
install-java-jdk.sh

# download file to Download folder
rm -rf $WORKING_PATH
cd ~/Downloads
wget -O $FILE_NAME "http://www.syntevo.com/static/smart/download/smartgit/smartgit-linux-$VER.tar.gz"
mkdir -p $PROGRAMS
tar zxf $FILE_NAME -C $PROGRAMS
cd $WORKING_PATH/bin
./remove-menuitem.sh
./add-menuitem.sh

rm -f ~/Downloads/$FILE_NAME
