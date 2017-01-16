#!/bin/bash


#check matlab version
MATLAB_VER=`matlab -e | grep -E -o R[0-9]+[ab] |uniq`

PREFIX=~/prefix
PROJECT_DIR=~/ANPL/code/3rdparty
FROM_GIT=True
GTSAM_VER="3.2.1"
#from https://wiki.ubuntu.com/ARM/Thumb2
#from http://stackoverflow.com/questions/10085945/cmake-cflags-cxxflags-modification
#from http://stackoverflow.com/questions/21047399/cmake-set-environment-variables-from-a-script
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS=-Wa,-mimplicit-it=thumb"
LINK="https://research.cc.gatech.edu/borg/sites/edu.borg/files/downloads/gtsam-$GTSAM_VER.zip"
GIT_LINK="https://bitbucket.org/gtborg/gtsam/ -b fix/boost158gtsam3"


sudo apt-get install libboost-all-dev libtbb-dev -y

install-gcc4.9.sh

#if there is matlab install on the machine
if [ ! -z "$MATLAB_VER" ]; then
	#flags for matlab
    CMAKE_FLAGS="$CMAKE_FLAGS -DGTSAM_INSTALL_MATLAB_TOOLBOX=ON -DMEX_COMMAND=/usr/local/MATLAB/$MATLAB_VER/bin/mex"
fi

sudo rm -rf $PROJECT_DIR/gtsam-$GTSAM_VER

if [ "$FROM_GIT" = True ]; then
    cd $PROJECT_DIR
    git clone $GIT_LINK gtsam-$GTSAM_VER
else
    # download file to Download folder
    cd ~/Downloads
    wget -O gtsam-$GTSAM_VER.zip $LINK
    unzip gtsam-$GTSAM_VER.zip -d $PROJECT_DIR
    rm -f ~/Downloads/gtsam-$GTSAM_VER.zip
fi

cd $PROJECT_DIR/gtsam-$GTSAM_VER

#from https://collab.cc.gatech.edu/borg/gtsam/#quickstart

mkdir build && cd build
cmake $CMAKE_FLAGS ..
make -j4
sudo make install -j4

echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:~/prefix/lib">>~/.bashrc
if [ ! -z "$MATLAB_VER" ]; then
    #save matlab the path for gtsam toolbox
    sudo matlab -nodesktop -nosplash -r "addpath(genpath('$PREFIX/gtsam_toolbox'));savepath;exit;"
fi
