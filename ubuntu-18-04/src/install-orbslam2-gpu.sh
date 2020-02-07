#!/bin/bash

PREFIX=/usr/ANPLprefix
PROJECT_DIR=~/ANPL/code/3rdparty
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release"
FOLDER_NAME_PANGOLIN=pangolin
FOLDER_NAME_ORB_SLAM_2=orb-slam2-gpu
LINK_PANGOLIN=https://github.com/stevenlovegrove/Pangolin
LINK_ORB_SLAM_2=https://github.com/yunchih/ORB-SLAM2-GPU2016-final
MAKE_FLAGS=-j7

# Install ORB SLAM2 and it's dependencies
# install libglew (for pangolin)
sudo apt-get install libglew-dev -y

#delete old pangolin library
sudo rm -rf $PROJECT_DIR/$FOLDER_NAME_PANGOLIN

cd $PROJECT_DIR
git clone $LINK_PANGOLIN $FOLDER_NAME_PANGOLIN
cd $FOLDER_NAME_PANGOLIN
mkdir build && cd build
cmake $CMAKE_FLAGS ..
make $MAKE_FLAGS
sudo make install $MAKE_FLAGS


#delete old orb-slam2 library
sudo rm -rf $PROJECT_DIR/$FOLDER_NAME_ORB_SLAM_2

cd $PROJECT_DIR
git clone $LINK_ORB_SLAM_2 $FOLDER_NAME_ORB_SLAM_2
cd $FOLDER_NAME_ORB_SLAM_2/Thirdparty/DBoW2
mkdir build && cd build
cmake $CMAKE_FLAGS ..
make $MAKE_FLAGS

echo "Configuring and building Thirdparty/g2o ..."
cd $PROJECT_DIR/$FOLDER_NAME_ORB_SLAM_2/Thirdparty/g2o
mkdir build && cd build
cmake $CMAKE_FLAGS ..
make $MAKE_FLAGS


echo "Uncompress vocabulary ..."
cd $PROJECT_DIR/$FOLDER_NAME_ORB_SLAM_2/Vocabulary
tar -xf ORBvoc.txt.tar.gz
cd ..

echo "Configuring and building ORB_SLAM2 ..."

cd $PROJECT_DIR/$FOLDER_NAME_ORB_SLAM_2/Thirdparty/g2o/g2o/solvers
sed -i '56s/SparseMatrix::Index/int/' linear_solver_eigen.h

cd $PROJECT_DIR/$FOLDER_NAME_ORB_SLAM_2
sed -i '44s/find_package(OpenCV 3.1.0/find_package(OpenCV 3.4.2/' CMakeLists.txt

cd $PROJECT_DIR/$FOLDER_NAME_ORB_SLAM_2
mkdir build && cd build
cmake $CMAKE_FLAGS ..
make $MAKE_FLAGS
mkdir -p ../lib/
cp lib/libORB_SLAM2.so ../lib/
