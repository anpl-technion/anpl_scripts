#!/bin/bash

VER='8_0_0'
PROGRAMS=~/ANPL/programs
WORKING_PATH=$PROGRAMS/smartgit/
install-java-jdk.sh

# download file to Download folder
rm -rf $WORKING_PATH
cd ~/Downloads
wget -O smartgit-$VER.tar.gz "http://www.syntevo.com/static/smart/download/smartgit/smartgit-linux-$VER.tar.gz"
tar zxf smartgit-$VER.tar.gz -C $PROGRAMS
cd $WORKING_PATH/bin
./remove-menuitem.sh
./add-menuitem.sh

rm -f ~/Downloads/smartgit-$VER.tar.gz
