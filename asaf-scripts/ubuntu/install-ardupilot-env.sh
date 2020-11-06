#!/bin/bash

#from http://dev.ardupilot.com/wiki/where-to-get-the-code/
#from http://dev.ardupilot.com/wiki/building-the-code/building-px4-for-linux-with-make/

PROJECT_DIR=~/ANPL/ardupilot-code

rm -rf $PROJECT_DIR
mkdir -p $PROJECT_DIR
cd $PROJECT_DIR

git clone git://github.com/amirgeva/ardupilot.git
git clone git://github.com/diydrones/PX4Firmware.git
git clone git://github.com/diydrones/PX4NuttX.git
git clone git://github.com/diydrones/uavcan.git

ardupilot/Tools/scripts/install-prereqs-ubuntu.sh -y
. ~/.profile


#Build for Copter:
cd ardupilot/ArduPlane
make configure
make px4-v2


sudo usermod -a -G dialout $USER
