#!/bin/bash
PREFIX=/usr/ANPLprefix
PROJECT_DIR=~/ANPL/code/3rdparty
LIBCCD_VER=2.0
FOLDER_NAME=libccd-$LIBCCD_VER
FILE_NAME=$FOLDER_NAME.zip
LINK=https://github.com/danfis/libccd/archive/v$LIBCCD_VER.zip
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release"


# Argument read.
# Script gets single argument or none.
#   --apt=<bool>    Set 'true' if you want to install the package from apt
# If no argument provided default value is used (false)

RED='\033[0;31m' # Red color text
NC='\033[0m' # No Color
if [ "$#" -eq  "0" ]; then
    FROM_APT=false
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
	# sudo apt-get autoremove libccd-dev 
	sudo apt-get install libccd-dev -y
	exit
else
    sudo rm -rf $PROJECT_DIR/$FOLDER_NAME
    cd ~/Downloads
    wget -O $FILE_NAME $LINK
    mkdir -p $PROJECT_DIR
    unzip $FILE_NAME -d $PROJECT_DIR
    rm -f ~/Downloads/$FILE_NAME
    cd $PROJECT_DIR/$FOLDER_NAME
    mkdir build && cd build
    cmake $CMAKE_FLAGS ..
    make -j4       
    sudo make install -j4
fi
