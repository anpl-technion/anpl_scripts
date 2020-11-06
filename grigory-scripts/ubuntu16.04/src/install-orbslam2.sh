#!/bin/bash


PROJECT_DIR=~/ANPL/code/3rdparty
ANPL_PREFIX=/usr/ANPLprefix
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$ANPL_PREFIX -DCMAKE_BUILD_TYPE=Release"
FOLDER_NAME_PANGOLIN=pangolin
FOLDER_NAME_ORB_SLAM_2=orb-slam2
LINK_PANGOLIN=https://github.com/stevenlovegrove/Pangolin
LINK_ORB_SLAM_2=https://bitbucket.org/ANPL/orb-slam2.git
MAKE_FLAGS=-j7

# Install ORB SLAM2 and it's dependencies
# install opencv 3
# install-opencv3.sh

cd src/
bash install-orbslam2-pangolin.sh

sudo bash install-orbslam2-build.sh
