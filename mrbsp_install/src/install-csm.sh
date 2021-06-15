#!/bin/bash

PREFIX=/usr/ANPLprefix
PROJECT_DIR=~/ANPL/code/3rdparty
LIBCSM_VER=1.0.2
FOLDER_NAME=csm-$LIBCSM_VER
FILE_NAME=$FOLDER_NAME.zip
LINK=https://github.com/AndreaCensi/csm/archive/$LIBCSM_VER.zip
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release"

JSON_C_BITS_LINES_TO_BE_COMMENTED=('#ifndef min' \
    '#define min(a,b) ((a) < (b) ? (a) : (b))' \
    '#endif' \
    '#ifndef max' \
    '#define max(a,b) ((a) > (b) ? (a) : (b))')
JSON_C_BITS_PATH=/usr/ANPLprefix/include/json-c/bits.h
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

sudo apt-get install libgsl-dev -y

if [ "$FROM_APT" = true ]; then
    sudo apt-get install ros-$ROS_DISTRO-csm    # supports kinetic and melodic
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

    for line in "${JSON_C_BITS_LINES_TO_BE_COMMENTED[@]}"; do
        sudo sed -i "s|${line}|//${line}|" $JSON_C_BITS_PATH
    done
    echo "#endif" | sudo tee -a $JSON_C_BITS_PATH
fi



