#!/bin/bash

PROJECT_DIR=~/ANPL/code
PREFIX=/usr/ANPLprefix
FOLDER_NAME=planar_icp
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release"


# Argument read.
# Script gets single argument or none.
#   -b=<branch name>, --branch=<branch name>  
# If no argument provided default value is used (master)

RED='\033[0;31m' # Red color text
NC='\033[0m' # No Color
if [ "$#" -eq  "0" ]; then
    BRANCH=master
else
    if [ "$#" -eq  "1" ]; then
        #FROM_APT=$(echo $1 | sed "s/^--apt=\(.*\)$/\1/")
        case $1 in
	    	-b=*|--branch=*)
                BRANCH="${1#*=}"
                echo PLANNAR BRANCH = $BRANCH
            ;;
            *)
                echo -e "${RED}ERROR at '${0##*/}': ${NC}\n$1: Unknown argument provided. Please rerun script with 1 argument: -b=<branch name>"
                exit
            ;;
        esac
    else
        echo "${RED}ERROR at '${0##*/}': ${NC}\nToo many arguments provided. Please rerun script with 1 argument: -b=<branch name>"
        exit
    fi
fi

sudo rm -rf $PROJECT_DIR/$FOLDER_NAME

cd $PROJECT_DIR
TMP=0
git clone -b $BRANCH https://bitbucket.org/ANPL/planar_icp $FOLDER_NAME && TMP=1
if [ $TMP -ne 1 ]; then  
 	echo -e "${RED}ERROR at '${0##*/}': ${NC}\ngit clone error. Check if provided branch name is correct. Please rerun script."
	exit
fi
cd $FOLDER_NAME

mkdir build && cd build
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$PREFIX/lib/pkgconfig/
cmake $CMAKE_FLAGS ..
make 
sudo make install

sudo mkdir -p $PREFIX/include/$FOLDER_NAME
cd $PROJECT_DIR/$FOLDER_NAME/cpp
sudo cp -f *.h $PREFIX/include/$FOLDER_NAME
