#!/bin/bash

ANPL_OPT=/opt/ANPL
CLION_VER=2018.1.6
CLION_DIR=$ANPL_OPT/clion
LINK=https://download-cf.jetbrains.com/cpp/CLion-$CLION_VER.tar.gz




#remove old clion
sudo rm -rf $CLION_DIR

#download clion file.
cd ~/Downloads
wget -O clion.tar.gz $LINK
tar -xvzf clion.tar.gz
mv clion-$CLION_VER clion
sudo mv clion $ANPL_OPT
rm -rf clion.tar.gz
/opt/ANPL/clion/bin/clion.sh
