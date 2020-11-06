#!/bin/bash
VERSION="2.8.3.1"
FILE_NAME="flycapture.${VERSION}_armhf.tar.gz"
DIR_EXTRACT="flycapture.${VERSION}_armhf"
INSTALL_DIR="/usr/lib"

#from https://www.ptgrey.com/tan/10548
#sudo apt-get install libraw1394-11 libgtkmm-2.4-1c2a libglademm-2.4-1c2a libgtkglextmm-x11-1.2-dev libgtkglextmm-x11-1.2 libusb-1.0-0 -y

printf "Username for 'https://bitbucket.org':"
#from http://ryanstutorials.net/bash-scripting-tutorial/bash-input.php
read USERNAME
printf "Password for 'https://$USERNAME@bitbucket.org':"
#from http://stackoverflow.com/questions/3980668/how-to-get-a-password-from-a-shell-script-without-echoing
read -s PASSWORD
echo ""
echo "Make sure you save your work, The script will reboot. Press any key to contine."
#from http://unix.stackexchange.com/questions/134437/press-space-to-continue 
read -n 1

cd ~/Downloads
rm -rf $FILE_NAME $DIR_EXTRACT/
#from http://stackoverflow.com/questions/3082107/how-to-pull-a-bitbucket-repository-without-access-to-hg
wget -O $FILE_NAME "https://$USERNAME:$PASSWORD@bitbucket.org/ANPL/binaries/raw/master/PointGrey/$FILE_NAME"

# untar the installation package:
tar xvfz flycapture.${VERSION}_armhf.tar.gz

# copy all libraries to system folders:
cd flycapture.${VERSION}_armhf/lib
sudo cp libflycapture.so* /usr/lib
cd ..
mv include/ flycapture/ 
sudo cp -r flycapture/ /usr/include/

# configure permissions to run PGR cameras:
sudo sh flycap2-conf

cd ~/ANPL/catkin_ws/src

rm -rf pointgrey_camera_driver/ image_common/
git clone https://github.com/ros-drivers/pointgrey_camera_driver
git clone https://github.com/ros-perception/image_common

cd ~/ANPL/catkin_ws
catkin_make

history -c
reboot
