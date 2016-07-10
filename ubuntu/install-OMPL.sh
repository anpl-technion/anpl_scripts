#!/bin/bash
#from http://ompl.kavrakilab.org/download.html

PREFIX=~/prefix
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX"

rm -rf ~/ANPL/code/3rdparty/omplapp
cd ~/ANPL/code/3rdparty
git clone https://github.com/ompl/omplapp.git
cd omplapp
git clone https://github.com/ompl/ompl.git

#from http://ompl.kavrakilab.org/installation.html

#Install Boost, CMake, Python, PyQt4, PyOpenGL, and pkg-config.
sudo apt-get install libboost-all-dev cmake python-dev python-qt4-dev python-qt4-gl python-opengl freeglut3-dev libassimp-dev -y

#To be able to generate documentation and build the OpenDE extension, the following packages are also needed:
sudo apt-get install doxygen graphviz libode-dev -y 

mkdir -p build-Release
cd build-Release
cmake $CMAKE_FLAGS ..

#If you want Python bindings or a GUI, type the following two commands:
make installpyplusplus -j4 && cmake . # download & install Py++
make update_bindings -j4
sudo make install -j4
