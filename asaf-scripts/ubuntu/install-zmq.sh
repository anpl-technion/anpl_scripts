#!/bin/bash
PROJECT_DIR=~/ANPL/code/3rdparty
INSTALL_DIR=$PROJECT_DIR/zeromq
ZMQ_VER=4.1.4

sudo apt-get install -y libtool pkg-config build-essential autoconf automake

cd ~
wget http://download.zeromq.org/zeromq-$ZMQ_VER.tar.gz
rm -rf $INSTALL_DIR
mkdir $INSTALL_DIR
tar xvfz zeromq-$ZMQ_VER.tar.gz -C $INSTALL_DIR --strip-components=1
rm -f zeromq-$ZMQ_VER.tar.gz
cd $INSTALL_DIR

./autogen.sh
./configure --without-libsodium 
make check
sudo make install
sudo ldconfig

git clone https://github.com/zeromq/cppzmq.git
sudo cp cppzmq/zmq.hpp /usr/local/include/

cd ~
rm -rf $INSTALL_DIR
