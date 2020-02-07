#!/bin/bash

PY_VERSION=3.5.2
PY_TAR_NAME=Python-$PY_VERSION
PY_LINK=https://www.python.org/ftp/python/$PY_VERSION/$PY_TAR_NAME.tgz
MAKE_FLAGS=-j7


sudo apt update
sudo apt install -y build-essential \
            zlib1g-dev \
            libncurses5-dev \
            libgdbm-dev \
            libnss3-dev \
            libssl-dev \
            libreadline-dev \
            libffi-dev wget

cd ~/Downloads

wget $PY_LINK
tar -xf $PY_TAR_NAME.tgz

cd $PY_TAR_NAME 
./configure --enable-optimizations
make $MAKE_FLAGS

sudo make altinstall

wait $!
cd ~/Downloads
sudo rm -fr $PY_TAR_NAME $PY_TAR_NAME.tgz