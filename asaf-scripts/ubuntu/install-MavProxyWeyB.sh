#!/bin/bash
#from https://pypi.python.org/pypi/MAVProxy

PROJECT_DIR=~/ANPL/MAV
MAVProxy_VER="1.4.20"

rm -rf $PROJECT_DIR/MAVProxy-*
cd ~/Downloads
wget --no-check-certificate -O MAVProxy.tar.gz "https://pypi.python.org/packages/source/M/MAVProxy/MAVProxy-$MAVProxy_VER.tar.gz"
tar -zxvf MAVProxy.tar.gz 
mv MAVProxy-$MAVProxy_VER $PROJECT_DIR
cd $PROJECT_DIR/MAVProxy-$MAVProxy_VER
sudo python setup.py install
