#!/bin/bash

PREFIX=/usr/ANPLprefix
PROJECT_DIR=~/ANPL/code/3rdparty

BOOST_VER=1.58.0
BOOST_VER_STR=`echo $BOOST_VER | tr . _`
BOOST_FOLDER_NAME=boost_$BOOST_VER_STR
BOOST_FILE_NAME=$BOOST_FOLDER_NAME.zip
BOOST_LINK=https://netix.dl.sourceforge.net/project/boost/boost/$BOOST_VER/boost_$BOOST_VER_STR.zip
#BOOTSTRAP_FLAGS="--prefix=$PREFIX --with-python=python"
BOOTSTRAP_FLAGS="--prefix=$PREFIX"
B2_FLAGS="link=static,shared threading=multi cxxflags=-fPIC cflags=-fPIC --disable-icu -j8"

GTSAM_VER="3.2.1"
GTSAM_FOLDER_NAME=gtsam-$GTSAM_VER
FROM_GIT=True
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DGTSAM_BUILD_TESTS=OFF -DGTSAM_BUILD_EXAMPLES_ALWAYS=OFF -DGTSAM_BUILD_UNSTABLE=OFF -DCMAKE_BUILD_TYPE=Release "
LINK="https://research.cc.gatech.edu/borg/sites/edu.borg/files/downloads/gtsam-$GTSAM_VER.zip"
GIT_LINK="https://github.com/anpl-technion/gtsam-3.2.1-anpl/ -b fix/boost158gtsam3"

UBUNTU_DISTRO=$(cat /etc/os-release | grep -i version_id | cut -d'"' -f2)

#########################################################################
# Boost installation
sudo apt-get install g++ cmake -y
sudo apt-get install python-dev libbz2-dev libtbb-dev libeigen3-dev -y
echo "[INFO] Installing BOOST 1.58 in process..."
case $UBUNTU_DISTRO in
	test ) echo "[INFO] skipping Boost..." ;;
	16.04 ) sudo apt-get install libboost-all-dev -y
		;;
	* ) 
		sudo mkdir -p $PREFIX
		sudo rm -rf $PROJECT_DIR/$BOOST_FOLDER_NAME
		cd ~/Downloads
		wget -O $BOOST_FILE_NAME $BOOST_LINK
		mkdir -p $PROJECT_DIR
		unzip $BOOST_FILE_NAME -d $PROJECT_DIR
		rm -f ~/Downloads/$BOOST_FILE_NAME
		cd $PROJECT_DIR/$BOOST_FOLDER_NAME

		./bootstrap.sh $BOOTSTRAP_FLAGS
		./b2 $B2_FLAGS
		sudo ./b2 install -j8

		echo "go to $PREFIX/include/boost/optional/optional.hpp and add #define BOOST_OPTIONAL_CONFIG_ALLOW_BINDING_TO_RVALUES to the headers"
		sudo sed -i '18 a #define BOOST_OPTIONAL_CONFIG_ALLOW_BINDING_TO_RVALUES' $PREFIX/include/boost/optional/optional.hpp
		;;
esac


#########################################################################
# GTSAM installation
echo "[INFO] Installing GTSAM 3.2.1 in process..."
sudo rm -rf $PROJECT_DIR/gtsam-*
mkdir -p $PROJECT_DIR

if [ $FROM_GIT = "True" ]; then
    cd $PROJECT_DIR

    while [ ! -d "$PROJECT_DIR/$GTSAM_FOLDER_NAME" ]; do
      git clone $GIT_LINK $GTSAM_FOLDER_NAME
    done
else
    # download file to Download folder
    cd ~/Downloads
    wget -O gtsam-$GTSAM_VER.zip $LINK
    unzip gtsam-$GTSAM_VER.zip -d $PROJECT_DIR
    rm -f ~/Downloads/gtsam-$GTSAM_VER.zip
fi

cd $PROJECT_DIR/$GTSAM_FOLDER_NAME

#from https://collab.cc.gatech.edu/borg/gtsam/#quickstart

mkdir build && cd build
cmake $CMAKE_FLAGS ..
make -j7
sudo make install -j7

