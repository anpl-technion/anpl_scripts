#!/bin/bash


#check matlab version
MATLAB_VER=`matlab -e | grep -E -o R[0-9]+[ab] |uniq`
CMAKE_FLAGS=""
PREFIX=~/prefix
PROJECT_DIR=~/ANPL/code/3rdparty
GTSAM_VER="3.2.1"
FROM_GIT=True

install-modules.sh
install-gcc4.7.sh

#if there is no matlab install on the machine
if [ ! -z "$MATLAB_VER" ]; then
	#flags for matlab
    CMAKE_FLAGS="-DGTSAM_INSTALL_MATLAB_TOOLBOX=ON -DMEX_COMMAND=/usr/local/MATLAB/$MATLAB_VER/bin/mex $CMAKE_FLAGS"
fi

CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX $CMAKE_FLAGS"

sudo rm -rf $PROJECT_DIR/gtsam-$GTSAM_VER

if [ ! "$FROM_GIT" = True ]; then
    # download file to Download folder
    cd ~/Downloads
    wget -O gtsam-$GTSAM_VER.zip "https://research.cc.gatech.edu/borg/sites/edu.borg/files/downloads/gtsam-$GTSAM_VER.zip"
    unzip gtsam-$GTSAM_VER.zip -d $PROJECT_DIR
    rm -f ~/Downloads/gtsam-$GTSAM_VER.zip
else
    cd $PROJECT_DIR
    git clone https://bitbucket.org/ANPL/gtsam-$GTSAM_VER.git   
fi

cd $PROJECT_DIR/gtsam-$GTSAM_VER

#from https://collab.cc.gatech.edu/borg/gtsam/#quickstart

mkdir build-release
cd build-release
sudo cmake $CMAKE_FLAGS ..
sudo make install -j4

echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:~/prefix/lib">>~/.bashrc
if [ ! -z "$MATLAB_VER" ]; then
    #save matlab the path for gtsam toolbox
    sudo matlab -nodesktop -nosplash -r "addpath(genpath('$PREFIX/gtsam_toolbox'));savepath;exit;"
fi
