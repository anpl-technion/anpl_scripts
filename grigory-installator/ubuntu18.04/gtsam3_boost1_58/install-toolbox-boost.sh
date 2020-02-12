#!/bin/bash

PREFIX=/usr/ANPLprefix/
PROJECT_DIR=~/ANPL/code/3rdparty
BOOST_VER=1.58.0
BOOST_VER_STR=`echo $BOOST_VER | tr . _`
BOOST_FOLDER_NAME=boost_$BOOST_VER_STR
FOLDER_NAME=boost_toolbox_$BOOST_VER_STR
FILE_NAME=$FOLDER_NAME.zip

LINK=https://netix.dl.sourceforge.net/project/boost/boost/$BOOST_VER/boost_$BOOST_VER_STR.zip
BOOTSTRAP_FLAGS="--prefix=$PREFIX/$BOOST_FOLDER_NAME --without-libraries=python"
B2_FLAGS="link=static,shared threading=multi cxxflags=-fPIC cflags=-fPIC --disable-icu"


sudo mkdir -p $PREFIX/$BOOST_FOLDER_NAME
sudo rm -rf $PROJECT_DIR/$FOLDER_NAME
cd ~/Downloads
wget -O $FILE_NAME $LINK
mkdir -p $PROJECT_DIR
unzip $FILE_NAME -d ~/Downloads/
mv $BOOST_FOLDER_NAME $FOLDER_NAME
mv $FOLDER_NAME $PROJECT_DIR 
rm -f ~/Downloads/$FILE_NAME
cd $PROJECT_DIR/$FOLDER_NAME

./bootstrap.sh $BOOTSTRAP_FLAGS
cat << EOF >> project-config.jam
using mpi ;
EOF

./b2 $B2_FLAGS
sudo ./b2 install

#bug in downloaded source of boost 1.58.
#sudo cp /usr/include/boost/numeric/ublas/storage.hpp $PREFIX/include/boost/numeric/ublas/


