#!/bin/bash

PREFIX=/usr/ANPL/boost_prefix
PROJECT_DIR=~/ANPL/code/3rdparty
BOOST_VER=1.58.0
BOOST_VER_STR=`echo $BOOST_VER | tr . _`
FOLDER_NAME=boost_$BOOST_VER_STR
FILE_NAME=$FOLDER_NAME.zip

LINK=https://netix.dl.sourceforge.net/project/boost/boost/$BOOST_VER/boost_$BOOST_VER_STR.zip
PROJECT_DIR=~/ANPL/code/3rdparty
BOOTSTRAP_FLAGS="--prefix=$PREFIX --with-python=python"
B2_FLAGS="link=static,shared threading=multi cxxflags=-fPIC cflags=-fPIC --disable-icu -j8"

install-gcc5.sh

sudo mkdir -p $PREFIX
sudo rm -rf $PROJECT_DIR/$FOLDER_NAME
cd ~/Downloads
wget -O $FILE_NAME $LINK
mkdir -p $PROJECT_DIR
unzip $FILE_NAME -d $PROJECT_DIR
rm -f ~/Downloads/$FILE_NAME
cd $PROJECT_DIR/$FOLDER_NAME

./bootstrap.sh $BOOTSTRAP_FLAGS
cat << EOF >> project-config.jam
using mpi ;
EOF

./b2 $B2_FLAGS
sudo ./b2 install -j8

#bug in downloaded source of boost 1.58.
#sudo cp /usr/include/boost/numeric/ublas/storage.hpp $PREFIX/include/boost/numeric/ublas/
