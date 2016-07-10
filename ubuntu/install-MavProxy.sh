#!/bin/bash

#http://tridge.github.io/MAVProxy/
#Linux
#Linux users can use the PyPi program to get the needed packages:
sudo apt-get install python-pip -y
#
#Then download and install MAVProxy. Prerequisites will be automatically downloaded too. Note a sudo may be required in some circumstances if the install generates errors.
sudo pip install MAVProxy pymavlink -y

#The following other packages may also be required:
sudo apt-get install python-opencv python-wxgtk

#Note that on some Linux systems, python-wxgtk may be instead named as python-wxgtk2.8.



#http://dev.ardupilot.com/wiki/droneapi-tutorial/
# examine : sudo apt-get install python-numpy python-serial python-pyparsing
sudo pip install droneapi

