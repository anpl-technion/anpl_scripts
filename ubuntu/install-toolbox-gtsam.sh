#!/bin/bash

#check matlab version
MATLAB_VER=`matlab -e | grep -E -o R[0-9]+[ab] |uniq`

PREFIX=/usr/ANPL/gtsam_toolbox_prefix
PROJECT_DIR=~/ANPL/code/3rdparty
FROM_GIT=True
GTSAM_VER="3.2.1"
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DGTSAM_BUILD_TESTS=OFF -DGTSAM_BUILD_EXAMPLES_ALWAYS=OFF -DGTSAM_BUILD_UNSTABLE=OFF -DCMAKE_BUILD_TYPE=Release"
CMAKE_FLAGS="$CMAKE_FLAGS -DGTSAM_INSTALL_MATLAB_TOOLBOX=ON -DMEX_COMMAND=/usr/local/MATLAB/$MATLAB_VER/bin/mex -DGTSAM_MEX_BUILD_STATIC_MODULE=ON -DBoost_USE_STATIC_LIBS=ON"
LINK="https://research.cc.gatech.edu/borg/sites/edu.borg/files/downloads/gtsam-$GTSAM_VER.zip"
GIT_LINK="https://bitbucket.org/ANPL/gtsam-3.2.1-anpl/ -b fix/boost158gtsam3"
FOLDER_NAME=gtsam_toolbox

#check if matlab available (if not then...)
if [ -z "$MATLAB_VER" ]; then
	#flags for matlab
    echo "Please install matlab (with link in /usr/local/bin) then run this script again"
    exit
fi


sudo rm -rf $PREFIX/$FOLDER_NAME
sudo rm -rf $PROJECT_DIR/gtsam-toolbox-$GTSAM_VER

cd $PROJECT_DIR
git clone $GIT_LINK gtsam-toolbox-$GTSAM_VER

cd $PROJECT_DIR/gtsam-toolbox-$GTSAM_VER

#from https://collab.cc.gatech.edu/borg/gtsam/#quickstart

mkdir build && cd build
cmake $CMAKE_FLAGS ..
make -j8
sudo make install -j8

#save matlab the path for gtsam toolbox
sudo matlab -nodesktop -nosplash -r "addpath(genpath('$PREFIX/$FOLDER_NAME'));savepath;exit;"

