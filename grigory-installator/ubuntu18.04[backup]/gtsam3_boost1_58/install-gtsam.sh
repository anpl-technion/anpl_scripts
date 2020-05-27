#!/bin/bash

PREFIX=/usr/ANPLprefix
PROJECT_DIR=~/ANPL/code/3rdparty
BOOST_PREFIX=/usr/ANPLprefix/boost_1_58_0
GTSAM_VER="3.2.1"
PROJECT_NAME=gtsam-$GTSAM_VER
FROM_GIT=True
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DGTSAM_BUILD_TESTS=OFF -DGTSAM_BUILD_EXAMPLES_ALWAYS=OFF -DGTSAM_BUILD_UNSTABLE=OFF -DCMAKE_BUILD_TYPE=Release -DBOOST_ROOT=$BOOST_PREFIX"
LINK="https://research.cc.gatech.edu/borg/sites/edu.borg/files/downloads/gtsam-$GTSAM_VER.zip"
GIT_LINK="https://bitbucket.org/ANPL/gtsam-3.2.1-anpl/ -b fix/boost158gtsam3"


# sudo apt-get install libboost-all-dev libtbb-dev -y


rm -rf $PROJECT_DIR/gtsam-*

if [ "$FROM_GIT" = True ]; then
    cd $PROJECT_DIR

    while [ ! -d "$PROJECT_DIR/$PROJECT_NAME" ]; do
      git clone $GIT_LINK $PROJECT_NAME
    done
else
    # download file to Download folder
    cd ~/Downloads
    wget -O gtsam-$GTSAM_VER.zip $LINK
    unzip gtsam-$GTSAM_VER.zip -d $PROJECT_DIR
    rm -f ~/Downloads/gtsam-$GTSAM_VER.zip
fi

cd $PROJECT_DIR/$PROJECT_NAME

#from https://collab.cc.gatech.edu/borg/gtsam/#quickstart

mkdir build && cd build
cmake $CMAKE_FLAGS ..
make -j4
make install -j4

# Add path to global variable of path library's 
echo "export LD_LIBRARY_PATH=/usr/ANPLprefix/lib:$LD_LIBRARY_PATH" >> ~/.bashrc


