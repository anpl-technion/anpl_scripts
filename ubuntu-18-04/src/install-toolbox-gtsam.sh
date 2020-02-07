#!/bin/bash

#check matlab version
MATLAB_VER=`matlab -e | grep -E -o R[0-9]+[ab] |uniq`

PREFIX=/usr/ANPLprefix
PROJECT_DIR=~/ANPL/code/3rdparty
FROM_GIT=True
GTSAM_VER="3.2.1"
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DGTSAM_BUILD_TESTS=OFF -DGTSAM_BUILD_EXAMPLES_ALWAYS=OFF -DGTSAM_BUILD_UNSTABLE=OFF -DCMAKE_BUILD_TYPE=Debug"
CMAKE_FLAGS="$CMAKE_FLAGS -DGTSAM_INSTALL_MATLAB_TOOLBOX=ON -DMEX_COMMAND=/usr/local/MATLAB/$MATLAB_VER/bin/mex -DGTSAM_MEX_BUILD_STATIC_MODULE=ON" #-DBoost_USE_STATIC_LIBS=ON
LINK="https://research.cc.gatech.edu/borg/sites/edu.borg/files/downloads/gtsam-$GTSAM_VER.zip"
GIT_LINK="https://bitbucket.org/ANPL/gtsam-3.2.1-anpl/ -b fix/boost158gtsam3"
GIT_LINK_4="https://bitbucket.org/gtborg/gtsam/"
GTSM_TOOLBOX_PROJECT_NAME=gtsam-toolbox-$GTSAM_VER
TOOLBOX_FOLDER=$PREFIX/gtsam_toolboxDebug

#check if matlab available (if not then...)
if [ -z "$MATLAB_VER" ]; then
    echo "Please install matlab (with link in /usr/local/bin) then run this script again"
    exit
fi

sudo apt-get install libboost-all-dev libtbb-dev -y
install-gcc5.sh

sudo rm -rf $PROJECT_DIR/gtsam-toolbox-*

cd $PROJECT_DIR

while [ ! -d "$PROJECT_DIR/$GTSM_TOOLBOX_PROJECT_NAME" ]; do
  git clone $GIT_LINK $GTSM_TOOLBOX_PROJECT_NAME
done

cd $PROJECT_DIR/$GTSM_TOOLBOX_PROJECT_NAME

#from https://collab.cc.gatech.edu/borg/gtsam/#quickstart

mkdir build && cd build
cmake $CMAKE_FLAGS ..
make -j7
sudo make install -j7

#save matlab the path for gtsam toolbox
sudo matlab -nodesktop -nosplash -r "addpath(genpath('$TOOLBOX_FOLDER'));savepath;exit;"


