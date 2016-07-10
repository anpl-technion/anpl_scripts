#!/bin/bash

#from http://charette.no-ip.com:81/programming/2011-12-24_GCCv47/
sudo apt-get install gcc-4.7 g++-4.7 -y

#from http://askubuntu.com/questions/26498/choose-gcc-and-g-version
sudo update-alternatives --remove-all gcc 
sudo update-alternatives --remove-all g++


sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.7 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.7
