#!/bin/bash

PREFIX=/usr/ANPLprefix
PROJECT_DIR=~/ANPL/code/3rdparty
GTSAM_VER="4.1.0"
BRANCH=release/$GTSAM_VER
PROJECT_NAME=gtsam-$GTSAM_VER
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DGTSAM_BUILD_TESTS=OFF -DGTSAM_BUILD_EXAMPLES_ALWAYS=OFF -DGTSAM_BUILD_UNSTABLE=OFF -DCMAKE_BUILD_TYPE=Release -DGTSAM_BUILD_WITH_MARCH_NATIVE=OFF"
GIT_LINK="https://github.com/borglab/gtsam.git"
FROM_APT=false

echo "[INFO] Installing GTSAM make dependencies..."
sudo apt-get install g++ cmake -y
sudo apt-get install python-dev libbz2-dev libtbb-dev -y
sudo apt-get install libboost-all-dev libtbb-dev libeigen3-dev -y
if [ $FROM_APT = false ]; then
	echo "[INFO] Installing GTSAM $GTSAM_VER in progress..."
	sudo rm -rf $PROJECT_DIR/gtsam-*
	mkdir -p $PROJECT_DIR
	cd $PROJECT_DIR
	while [ ! -d "$PROJECT_DIR/$PROJECT_NAME" ]; do
      		git clone $GIT_LINK $PROJECT_NAME --branch $BRANCH
	done
	cd $PROJECT_DIR/$PROJECT_NAME

	#from https://collab.cc.gatech.edu/borg/gtsam/#quickstart
	mkdir build && cd build
	cmake $CMAKE_FLAGS ..
	make -j4
	sudo make install -j4
	echo "export LD_LIBRARY_PATH=$PREFIX/lib:$LD_LIBRARY_PATH" >> ~/.bashrc
else
	sudo add-apt-repository ppa:borglab/gtsam-develop
	sudo apt update
	sudo apt install libgtsam-dev libgtsam-unstable-dev -y
fi
