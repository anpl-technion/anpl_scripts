#!/bin/bash
VERSION=1.0
FILE_NAME="realsense_dist_nav-v$VERSION.zip"
DIR_EXTRACT="realsense_dist_nav"
INSTALL_DIR="/opt/ros/$ROS_DISTRO/share/realsense_navigation"

printf "Username for 'https://bitbucket.org':"
#from http://ryanstutorials.net/bash-scripting-tutorial/bash-input.php
read USERNAME
printf "Password for 'https://$USERNAME@bitbucket.org':"
#from http://stackoverflow.com/questions/3980668/how-to-get-a-password-from-a-shell-script-without-echoing
read -s PASSWORD
echo "Make sure that the camera is plug in, Press any key when connected"
#from http://unix.stackexchange.com/questions/134437/press-space-to-continue 
read -n 1

cd ~/Downloads
rm -rf $FILE_NAME $DIR_EXTRACT/
#from http://stackoverflow.com/questions/3082107/how-to-pull-a-bitbucket-repository-without-access-to-hg
wget -O $FILE_NAME "https://$USERNAME:$PASSWORD@bitbucket.org/ANPL/binaries/raw/master/realsense/$FILE_NAME"
unzip $FILE_NAME -d .

cd $DIR_EXTRACT/$VERSION
sudo rm -rf $INSTALL_DIR
sh install_realsense_navigation.sh

cd ~/Downloads
rm -rf $FILE_NAME $DIR_EXTRACT/

#from http://www.howtogeek.com/179022/how-to-clear-the-terminal-history-on-linux-or-mac-os-x/
# clear command history that other users will not hack and revel passwords. 
history -c