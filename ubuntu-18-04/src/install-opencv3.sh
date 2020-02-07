#!/bin/bash

PROJECT_DIR=~/ANPL/code/3rdparty
OPENCV_VER=3.4.2
OPEN_CV_FOLDER_NAME=opencv-$OPENCV_VER
OPEN_CV_LINK=https://github.com/opencv/opencv/archive/$OPENCV_VER.zip
OPEN_CV_FILE_NAME=opencv-$OPENCV_VER.zip
CMAKE_FLAGS="cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DWITH_CUDA=ON -DENABLE_FAST_MATH=1 -DCUDA_FAST_MATH=1 -DWITH_CUBLAS=1 -DWITH_GTK=ON -DWITH_TBB=ON -DBUILD_PYTHON_SUPPORT=ON -DWITH_LIBV4L=ON -DWITH_GSTREAMER=ON -DWITH_GSTREAMER_0_10=OFF -DWITH_QT=ON -DBUILD_PERF_TESTS=OFF -DBUILD_TESTS=OFF"
MAKE_FLAGS=-j8
FROM_APT=true

if [ $FROM_APT = true]; then
    # sudo apt-get autoremove ros-$ROS_DISTRO-opencv3 
    sudo apt-get install ros-$ROS_DISTRO-opencv3 -y
    exit
fi


# pre-requierments
# compiler
sudo apt-get install -y \
    libavcodec-dev \
    libpostproc-dev \
    libavformat-dev \
    libavutil-dev \
    libeigen3-dev \
    libglew-dev \
    libgtk2.0-dev \
    libgtk-3-dev \
    libjasper-dev \
    libjpeg-dev \
    libpng12-dev \
    libswscale-dev \
    libtbb-dev \
    libtiff5-dev \
    libv4l-dev \
    libxvidcore-dev \
    libx264-dev \
    libdc1394-22-dev \
    libgphoto2-dev \
    libavresample-dev \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    qt5-default \
    zlib1g-dev \
    python-dev \
    python-numpy \
    libopenexr-dev \
    libopenblas-dev \
    liblapacke-dev 

sudo rm -rf $PROJECT_DIR/$OPEN_CV_FOLDER_NAME

cd ~/Downloads

wget -O $OPEN_CV_FILE_NAME $OPEN_CV_LINK
unzip $OPEN_CV_FILE_NAME -d $PROJECT_DIR
sudo rm -rf ~/Downloads/$OPEN_CV_FILE_NAME

cd $PROJECT_DIR/
cd $OPEN_CV_FOLDER_NAME

mkdir build && cd build
cmake $CMAKE_FLAGS ..
make $MAKE_FLAGS      
sudo make install $MAKE_FLAGS

