#!/bin/bash

PREFIX=/usr/ANPLprefix/
PROJECT_DIR=~/ANPL/code/3rdparty
BOOST_VER=1.58.0
BOOST_VER_STR=`echo $BOOST_VER | tr . _`
BOOST_FOLDER_NAME=boost_$BOOST_VER_STR
FOLDER_NAME=boost_toolbox_$BOOST_VER_STR
FILE_NAME=$FOLDER_NAME.zip
GOOGLEDRIVE=True

LINK=https://netix.dl.sourceforge.net/project/boost/boost/$BOOST_VER/boost_$BOOST_VER_STR.zip
BOOTSTRAP_FLAGS="--prefix=$PREFIX/$BOOST_FOLDER_NAME --without-libraries=python"
B2_FLAGS="link=static,shared threading=multi cxxflags=-fPIC cflags=-fPIC --disable-icu"


sudo mkdir -p $PREFIX/$BOOST_FOLDER_NAME
sudo rm -rf $PROJECT_DIR/$FOLDER_NAME
cd ~/Downloads
if [ "$GOOGLEDRIVE" = True ]; then
	wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1OzXuZ3U7pYeJkFcxWf73pNRx6FahAnpE' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1OzXuZ3U7pYeJkFcxWf73pNRx6FahAnpE" -O $FILE_NAME && rm -rf /tmp/cookies.txt
else
	wget -O $FILE_NAME $LINK
fi
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


