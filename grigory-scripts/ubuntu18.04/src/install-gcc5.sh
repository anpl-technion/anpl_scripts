#!/bin/bash

GCC_VER=5

#from http://charette.no-ip.com:81/programming/2011-12-24_GCCv47/
sudo apt-get install gcc-$GCC_VER g++-$GCC_VER -y

#from http://askubuntu.com/questions/26498/choose-gcc-and-g-version
# sudo update-alternatives --remove-all gcc 
# sudo update-alternatives --remove-all g++


sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-$GCC_VER 60 --slave /usr/bin/g++ g++ /usr/bin/g++-$GCC_VER
sudo update-alternatives --config gcc