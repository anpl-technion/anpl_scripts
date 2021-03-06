#!/bin/bash

PREFIX=/usr/ANPLprefix
PROJECT_DIR=~/ANPL/code/3rdparty
LIBFCL_VER=0.5.0
FOLDER_NAME=libfcl-$LIBFCL_VER
FILE_NAME=$FOLDER_NAME.zip
LINK=https://github.com/flexible-collision-library/fcl/archive/$LIBFCL_VER.zip
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release -DFCL_BUILD_TESTS=OFF"


# Argument read.
# Script gets single argument or none.
#   --apt=<bool>    Set 'true' if you want to install the package from apt
# If no argument provided default value is used (false)

RED='\033[0;31m' # Red color text
NC='\033[0m' # No Color
if [ "$#" -eq  "0" ]; then
    FROM_APT=true
else
    if [ "$#" -eq  "1" ]; then
        #FROM_APT=$(echo $1 | sed "s/^--apt=\(.*\)$/\1/")
        case $1 in
            --apt=*)
                FROM_APT="${1#*=}"
                if [[ $FROM_APT != true && $FROM_APT != false ]]; then
                    echo -e "${RED}ERROR at '${0##*/}': ${NC}\n$1: Unknown argument, BOOL expected. Please rerun script with 1 argument: --apt=<bool>"
                    exit
                fi
            ;;
            *)
                echo -e "${RED}ERROR at '${0##*/}': ${NC}\n$1: Unknown argument provided. Please rerun script with 1 argument: --apt=<bool>"
                exit
            ;;
        esac
    else
        echo "${RED}ERROR at '${0##*/}': ${NC}\n Too many arguments provided. Please rerun script with 1 argument: --apt=<bool>"
        exit
    fi
fi

if [ $FROM_APT = true ]; then
	# sudo apt-get autoremove libfcl-0.5-dev 
	UBUNTU_DISTRO=$(cat /etc/os-release | grep -i version_id | cut -d'"' -f2)
	case $UBUNTU_DISTRO in
		16.04) sudo apt-get install libfcl-0.5-dev -y;;
		18.04) sudo apt-get install libfcl-dev -y;;
		*) read -p $'Installation script currently only available on Ubuntu 16.04 and Ubuntu 16.04. Installation cancelled.'
			exit;;
	esac
	exit
else
	sudo rm -rf $PROJECT_DIR/$FOLDER_NAME
	cd ~/Downloads
	wget -O $FILE_NAME $LINK
	mkdir -p $PROJECT_DIR
	unzip $FILE_NAME -d $PROJECT_DIR
	rm -f ~/Downloads/$FILE_NAME
	cd $PROJECT_DIR/
	mv fcl-$LIBFCL_VER $FOLDER_NAME
	cd $FOLDER_NAME
	mkdir build && cd build
	cmake $CMAKE_FLAGS ..
	make -j4       
	sudo make install -j4
fi