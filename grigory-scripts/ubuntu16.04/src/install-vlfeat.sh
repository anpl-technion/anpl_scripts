#!/bin/bash

#from http://www.vlfeat.org/compiling-unix.html
#from http://www.vlfeat.org/download.html
#from https://github.com/vlfeat/vlfeat

VLFEAT_VER=0.9.21
PROJECT_DIR=/usr/ANPLprefix
FILE_NAME=vlfeat-$VLFEAT_VER.tar.gz
LINK=http://www.vlfeat.org/download/vlfeat-$VLFEAT_VER-bin.tar.gz
INSTALL_DIR=$PROJECT_DIR/vlfeat-$VLFEAT_VER/toolbox
FROM_APT=true

if [ $FROM_APT = true ]; then
	# sudo apt-get autoremove libvlfeat-dev
	sudo apt-get install libvlfeat-dev -y
	exit
fi

sudo rm -rf $PROJECT_DIR/vlfeat-*
cd ~/Downloads
wget -O $FILE_NAME $LINK
tar -xvzf $FILE_NAME
sudo mv vlfeat-$VLFEAT_VER $PROJECT_DIR
rm -rf $FILE_NAME

sudo matlab -nodesktop -nosplash -r "run('$INSTALL_DIR/vl_setup');savepath;exit;"
