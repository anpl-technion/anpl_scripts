#!/bin/bash


PROJECT_DIR=~/ANPL/code/3rdparty
ANPL_PREFIX=/usr/ANPLprefix
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$ANPL_PREFIX -DCMAKE_BUILD_TYPE=Release" #-DOpenCV_DIR=/opt/ros/kinetic/share/OpenCV-3.3.1-dev"
FOLDER_NAME_PANGOLIN=pangolin
FOLDER_NAME_ORB_SLAM_2=orb-slam2
LINK_PANGOLIN=https://github.com/stevenlovegrove/Pangolin
LINK_ORB_SLAM_2=https://bitbucket.org/ANPL/orb-slam2.git
MAKE_FLAGS=-j7

#delete old orb-slam2 library
sudo rm -rf $ANPL_PREFIX/$FOLDER_NAME_ORB_SLAM_2

cd $ANPL_PREFIX
git clone $LINK_ORB_SLAM_2 $FOLDER_NAME_ORB_SLAM_2
cd $FOLDER_NAME_ORB_SLAM_2
cd Thirdparty/DBoW2
mkdir build && cd build
cmake $CMAKE_FLAGS ..
make $MAKE_FLAGS

echo "Configuring and building Thirdparty/g2o ..."
cd ../../g2o
mkdir build && cd build
cmake $CMAKE_FLAGS ..
make $MAKE_FLAGS


echo "Uncompress vocabulary ..."
cd ../../../Vocabulary
tar -xf ORBvoc.txt.tar.gz
cd ..

echo "Configuring and building ORB_SLAM2 ..."

mkdir build && cd build
cmake $CMAKE_FLAGS ..
make $MAKE_FLAGS
cd .. && rm -rf build
cd .. && sudo mv $FOLDER_NAME_ORB_SLAM_2 $ANPL_PREFIX
